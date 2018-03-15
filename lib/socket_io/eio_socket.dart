import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:nodebb/application/application.dart';
import 'package:nodebb/socket_io/eio_client.dart';
import 'package:nodebb/socket_io/eio_parser.dart';
import 'package:nodebb/utils/utils.dart' as utils;

enum EngineIOSocketStatus { INITIAL, OPENING, OPEN, CLOSING, CLOSED }

enum EngineIOSocketEventType { OPEN, CLOSE, SEND, RECEIVE, FLUSH, ERROR }

class EngineIOSocketEvent {

  EngineIOSocketEventType type;

  dynamic data;

  EngineIOSocketEvent(this.type, [this.data]);

  @override
  String toString() {
    return '{type: $type, data: $data}';
  }
}
//todo clear write buffer and receive buffer?
class EngineIOSocket  {

  EngineIOClient owner;

  String sid; //会话id

  Duration pingInterval;

  Duration pingTimeout;

  Timer _pingIntervalTimer;

  Timer _pingTimeoutTimer;

  List<EngineIOPacket> writeBuffer;

  String uri;

  WebSocket socket;

  bool useBinary = false;

  Converter converter;

  StreamSubscription<EngineIOPacket> _subscription;

  EngineIOSocketStatus _readyStatus = EngineIOSocketStatus.INITIAL;

  //Completer _openCompleter;

  StreamController<EngineIOSocketEvent> _eventController = new StreamController.broadcast();

  Stream<EngineIOSocketEvent> get  eventStream => _eventController.stream;

  bool forceClose = false;

  EngineIOSocketStatus get readyStatus {
    return _readyStatus == null ? EngineIOSocketStatus.INITIAL : _readyStatus;
  }

  set readyStatus(EngineIOSocketStatus status) {
    _readyStatus = status;
    if(_readyStatus == EngineIOSocketStatus.OPEN) {
//      if(_openCompleter != null) {
//        _openCompleter.complete();
//      }
      _eventController.add(new EngineIOSocketEvent(EngineIOSocketEventType.OPEN));
    }
  }

  EngineIOSocket({this.uri, this.converter, this.sid, this.owner}) {
    if(converter == null) {
      converter = new EngineIOPacketDecoder();
    }
    writeBuffer = new List<EngineIOPacket>();
  }

  connect() async {
    if(readyStatus == EngineIOSocketStatus.INITIAL
        || readyStatus == EngineIOSocketStatus.CLOSED) {
      readyStatus = EngineIOSocketStatus.OPENING;
      //_openCompleter = new Completer();
      try {
        Map<String, String> headers = new Map();
        Uri _uri = Uri.parse(uri);
        List<Cookie> cookies =  owner.jar.getCookies(_uri);
        var cookieStr = owner.jar.serializeCookies(cookies);
        if(cookieStr != null && cookieStr.length > 0) {
          headers[HttpHeaders.COOKIE] = cookieStr;
          Application.logger.fine('send cookie: $cookieStr');
        }
        headers['origin'] = ('ws' == _uri.scheme ? 'http://' : 'https://') + '${_uri.host}:${_uri.port}';
        headers['host'] = '${_uri.host}:${_uri.port}';
        Application.logger.fine('establish engineiosocket connect: $uri');
        socket = await WebSocket.connect(uri, headers: headers);
        _subscription = socket.transform(this.converter).listen(null)
          ..onData((data) {
            onPacket(data);
          })
          ..onError((e) {
            onError(e);
          });
        Application.logger.fine('establish engineiosocket success: $uri');
      } catch(e) {
        Application.logger.warning('establish enginesocket fail: $uri, error: $e');
        readyStatus = EngineIOSocketStatus.CLOSED;
        //_openCompleter.completeError(e);
        _eventController.add(new EngineIOSocketEvent(EngineIOSocketEventType.ERROR, e));
      }
      //return await _openCompleter.future;
    }
  }

  close([reason]) async {
    if(readyStatus == EngineIOSocketStatus.OPEN
        || readyStatus == EngineIOSocketStatus.OPENING) {
      readyStatus = EngineIOSocketStatus.CLOSING;
      String _reasonMsg = 'socket: $sid force close';
      if(reason is Error || reason is Exception) {
        _reasonMsg = reason.toString();
      } else {
        forceClose = true;
      }
      await socket.close();
      onClose(_reasonMsg);
    }
  }

  ping() {
    Application.logger.fine('socket $sid ping');
    this.sendPacket(new EngineIOPacket(type: EngineIOPacketType.PING));
  }

  setPing() {
    if(_pingIntervalTimer != null) _pingIntervalTimer.cancel();
    _pingIntervalTimer = new Timer(pingInterval, () {
      ping();
      onHeartbeat(pingTimeout);
    });
  }

  sendPacket(EngineIOPacket packet) {
    if(readyStatus == EngineIOSocketStatus.CLOSED) return;
    writeBuffer.add(packet);
    flush();
  }

  flush() {
    if(readyStatus == EngineIOSocketStatus.OPEN) {
      new Stream.fromIterable(writeBuffer)
          .transform(new EngineIOPacketEncoder()).listen(null)
        ..onData((data) {
          Application.logger.fine('socket: $sid send: $data');
          socket.add(data);
          _eventController.add(new EngineIOSocketEvent(EngineIOSocketEventType.SEND, data));
        })..onDone(() {
        writeBuffer.clear();
        _eventController.add(new EngineIOSocketEvent(EngineIOSocketEventType.FLUSH));
      });

    }
  }

  pause() {
    if(readyStatus == EngineIOSocketStatus.OPEN) {
      _subscription.pause();
    }
  }

  resume() {
    if(readyStatus == EngineIOSocketStatus.OPEN) {
      _subscription.resume();
    }
  }

  onOpen() {
    readyStatus = EngineIOSocketStatus.OPEN;
    flush(); //把缓存的信息发出去
  }

  onClose(reason) {
    if(readyStatus == EngineIOSocketStatus.CLOSED) return;
    readyStatus = EngineIOSocketStatus.CLOSED;
    _subscription.cancel();
    _pingTimeoutTimer.cancel();
    _pingIntervalTimer.cancel();
    _eventController.add(new EngineIOSocketEvent(EngineIOSocketEventType.CLOSE));
  }

  onPacket(EngineIOPacket packet) {
    Application.logger.fine('socket: $sid receive $packet');
    switch(packet.type) {
      case EngineIOPacketType.OPEN:
        onHandshake(packet);
        break;
      case EngineIOPacketType.CLOSE:
        break;
      case EngineIOPacketType.MESSAGE:
        break;
      case EngineIOPacketType.PING:
        break;
      case EngineIOPacketType.PONG:
        setPing();
        break;
      case EngineIOPacketType.NOOP:
        break;
      case EngineIOPacketType.UPGRADE:
        break;
    }
    _eventController.add(new EngineIOSocketEvent(EngineIOSocketEventType.RECEIVE, packet));
    this.onHeartbeat();
  }

  onHeartbeat([Duration timeout]) {
    if(_pingTimeoutTimer != null) _pingTimeoutTimer.cancel();
    if(timeout == null) {
      timeout = new Duration(milliseconds:
      pingTimeout.inMilliseconds + pingInterval.inMilliseconds);
    }
    _pingTimeoutTimer = new Timer(timeout, () {
      if(readyStatus == EngineIOSocketStatus.CLOSED) return;
      Application.logger.fine('ping timeout');
      onClose('ping timeout');
    });
  }

  onHandshake(EngineIOPacket packet) {
    Map<String, String> data = JSON.decode(packet.data);
    sid = data['sid'];
    pingInterval = new Duration(milliseconds: utils.convertToInteger(data['pingInterval']));
    pingTimeout = new Duration(milliseconds:  utils.convertToInteger(data['pingTimeout']));
    onOpen();
    setPing();
  }

  onError(e) {
    close(e);
//    if(!_openCompleter.isCompleted) {
//      _openCompleter.completeError(e);
//    }
    //_subscription.cancel(); //todo
    _eventController.add(new EngineIOSocketEvent(EngineIOSocketEventType.ERROR, e));
  }

}