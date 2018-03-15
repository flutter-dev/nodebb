import 'dart:async';
import 'package:nodebb/application/application.dart';
import 'package:nodebb/services/cookie_jar.dart';
import 'package:nodebb/socket_io/eio_socket.dart';

enum EngineIOEventType { OPEN, CLOSE, ERROR, RECEIVE_PACKET, SEND_PACKET, RECONNECT, RECONNECT_FAIL, RECONNECT_ATTEMPT }

class EngineIOEvent {

  EngineIOEventType type;

  dynamic data;

  EngineIOEvent(this.type, [this.data]);

  @override
  String toString() {
    return '{type: $type, data: $data}';
  }
}

class _EngineIOSocketRecord {

  EngineIOSocket socket;

  int reconnectTrys = 0;

  _EngineIOSocketRecord(this.socket);
}

class EngineIOClient {

  bool autoReconnect;

  int maxReconnectTry;

  int reconnectInterval;

  CookieJar jar;

  Map<String, _EngineIOSocketRecord> sockets = new Map();

  StreamController<EngineIOEvent> _eventController = new StreamController.broadcast();

  Stream<EngineIOEvent> get  eventStream => _eventController.stream;

  EngineIOClient({
    this.autoReconnect = true,
    this.maxReconnectTry = 3,
    this.reconnectInterval = 1000,
    this.jar
  });

  get socketsCount => sockets.values.length;

  connect(String uri, [forceNew = false]) async {
    EngineIOSocket existsSocket = getExistsSocket(uri);
    if(!forceNew && existsSocket != null) return existsSocket;
    EngineIOSocket socket = new EngineIOSocket(uri: uri, owner: this);
    StreamSubscription<EngineIOSocketEvent> sub;
    sub = socket.eventStream.listen((EngineIOSocketEvent event) async {
      switch(event.type) {
        case EngineIOSocketEventType.CLOSE:
          _EngineIOSocketRecord record = sockets[socket.sid];
          if(record == null) return;
          if(autoReconnect && !record.socket.forceClose) {
            if(record.reconnectTrys < maxReconnectTry) {
              String _oldSid = socket.sid;
              _eventController.add(new EngineIOEvent(EngineIOEventType.RECONNECT, record.socket));
              while(record.reconnectTrys < maxReconnectTry) {
                try {
                  Application.logger.fine('socket: ${socket.sid} try reconnet ${record.reconnectTrys}');
                  _eventController.add(new EngineIOEvent(EngineIOEventType.RECONNECT_ATTEMPT, record.socket));
                  await record.socket.connect();
                  sockets.remove(_oldSid); //remove old
//                  record.reconnectTrys = 0; //reset
//                  sockets[socket.sid] = record;
                  return;
                } catch(err) {
                  Application.logger.fine('socket: ${record.socket.sid} error: $err');
                  record.reconnectTrys++;
                  await new Future.delayed(new Duration(milliseconds: reconnectInterval));
                }
              }
            }
            _eventController.add(new EngineIOEvent(EngineIOEventType.RECONNECT_FAIL, socket));
            Application.logger.fine('socket: ${socket.sid} exceed max retry: $maxReconnectTry');
          }
          sockets.remove(record.socket.sid);
          record.socket.owner = null;
          sub.cancel();
          _eventController.add(new EngineIOEvent(EngineIOEventType.CLOSE, record.socket));
          break;
        case EngineIOSocketEventType.OPEN:
          if(!sockets.containsKey(socket.sid)) {
            sockets[socket.sid] = new _EngineIOSocketRecord(socket);
          }
          _eventController.add(new EngineIOEvent(EngineIOEventType.OPEN, socket));
          break;
        case EngineIOSocketEventType.SEND:
          _eventController.add(new EngineIOEvent(EngineIOEventType.SEND_PACKET, event.data));
          break;
        case EngineIOSocketEventType.RECEIVE:
          _eventController.add(new EngineIOEvent(EngineIOEventType.RECEIVE_PACKET, event.data));
          break;
        case EngineIOSocketEventType.ERROR:
          _eventController.add(new EngineIOEvent(EngineIOEventType.ERROR, event.data));
          break;
        case EngineIOSocketEventType.FLUSH:
          break;
      }
    });
    await socket.connect();
    return socket;
  }

  getExistsSocket(uri) {
    for(_EngineIOSocketRecord record in sockets.values) {
      if(record.socket.uri == uri) {
        return record.socket;
      }
    }
    return null;
  }

  closeAll() async {
    for(_EngineIOSocketRecord record in sockets.values) {
      await record.socket.close();
    }
    sockets.clear();
  }

}