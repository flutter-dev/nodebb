import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:nodebb/application/application.dart';
import 'package:nodebb/socket_io/eio_client.dart';
import 'package:nodebb/socket_io/eio_parser.dart';
import 'package:nodebb/socket_io/errors.dart';
import 'package:nodebb/utils/utils.dart' as utils;

enum EngineIOSocketStatus { INITIAL, OPENING, OPEN, RECONNECT, CLOSING, CLOSED }

enum EngineIOSocketEventType { OPEN, CLOSE, RECONNECT_ATTEMPT, RECONNECT_SUCCESS, RECONNECT_FAIL, SEND, RECEIVE, FLUSH, ERROR }

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

  bool autoReconnect;

  int maxReconnectTrys;

  int reconnectInterval;

  int reconnectTrys = 0;

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
  }

  EngineIOSocket({
    this.uri,
    this.converter,
    this.sid,
    this.owner,
    this.autoReconnect = true,
    this.maxReconnectTrys = 3,
    this.reconnectInterval = 1000,
  }) {
    if(converter == null) {
      converter = new EngineIOPacketDecoder();
    }
    writeBuffer = new List<EngineIOPacket>();
  }

  connect() async {
    if(readyStatus == EngineIOSocketStatus.INITIAL
        || readyStatus == EngineIOSocketStatus.CLOSED) {
      readyStatus = EngineIOSocketStatus.OPENING;
      try {
       await reconnect();
      } catch(e) {
        Application.logger.warning('enginesocket establish fail: $uri, error: $e');
        readyStatus = EngineIOSocketStatus.CLOSED;
        _eventController.add(new EngineIOSocketEvent(EngineIOSocketEventType.ERROR, e));
      }
    }
  }

  reconnect() async {
    Map<String, String> headers = new Map();
    Uri _uri = Uri.parse(uri);
    List<Cookie> cookies =  owner.jar.getCookies(_uri);
    var cookieStr = owner.jar.serializeCookies(cookies);
    if(cookieStr != null && cookieStr.length > 0) {
      headers[HttpHeaders.COOKIE] = cookieStr;
      Application.logger.fine('enginiosocket send cookie: $cookieStr');
    }
    headers['origin'] = ('ws' == _uri.scheme ? 'http://' : 'https://') + '${_uri.host}:${_uri.port}';
    headers['host'] = '${_uri.host}:${_uri.port}';
    Application.logger.fine('establish engineiosocket connect: $uri');
    socket = await WebSocket.connect(uri, headers: headers);
    _subscription?.cancel();
    _subscription = socket.transform(this.converter).listen(null)
      ..onData((data) {
        onPacket(data);
      })
      ..onError((e) {
        onError(e);
      });
    Application.logger.fine('engineiosocket establish success: $uri');
  }

  tryReconnect() async {
    if(autoReconnect && !forceClose) {
      while(reconnectTrys < maxReconnectTrys) {
        readyStatus = EngineIOSocketStatus.RECONNECT;
        try {
          Application.logger.fine('enginiosocket: $sid try reconnet $reconnectTrys');
          _eventController.add(new EngineIOSocketEvent(EngineIOSocketEventType.RECONNECT_ATTEMPT));
          await reconnect();
          reconnectTrys = 0;
          _eventController.add(new EngineIOSocketEvent(EngineIOSocketEventType.RECONNECT_SUCCESS));
          return;
        } catch(err) {
          Application.logger.fine('enginiosocket: $sid error: $err');
          reconnectTrys++;
          await new Future.delayed(new Duration(milliseconds: reconnectInterval));
        }
      }
      _eventController.add(new EngineIOSocketEvent(EngineIOSocketEventType.RECONNECT_FAIL));
      close(new EngineIOReconnectFailException());
      Application.logger.fine('enginiosocket: $sid exceed max retry: $maxReconnectTrys');
      return;
    }
    close();
  }

  close([reason]) async {
    if(readyStatus == EngineIOSocketStatus.OPEN
        || readyStatus == EngineIOSocketStatus.OPENING
        || readyStatus == EngineIOSocketStatus.RECONNECT) {
      forceClose = true;
      readyStatus = EngineIOSocketStatus.CLOSING;
//      String _reasonMsg = 'enginiosocket: $sid will be closed';
//      if(reason is Error || reason is Exception) {
//        _reasonMsg = reason.toString();
//      } else {
//
//      }
      await socket.close();
      onClose(reason);
    }
  }

  ping() {
    Application.logger.fine('enginiosocket: $sid ping');
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
      new Stream.fromIterable(writeBuffer.toList())
          .transform(new EngineIOPacketEncoder()).listen(null)
        ..onData((data) {
          Application.logger.fine('enginiosocket: $sid send: $data');
          socket.add(data);
          _eventController.add(new EngineIOSocketEvent(EngineIOSocketEventType.SEND, data));
        })..onDone(() {
        _eventController.add(new EngineIOSocketEvent(EngineIOSocketEventType.FLUSH));
      });
      writeBuffer.clear();
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
    Application.logger.fine('enginiosocket: $sid is closed');
    _eventController.add(new EngineIOSocketEvent(EngineIOSocketEventType.CLOSE, reason));
  }

  onPacket(EngineIOPacket packet) {
    Application.logger.fine('enginiosocket: $sid receive $packet');
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
      Application.logger.warning('enginiosocket: $sid ping timeout');
      //close(new EngineIOPingTimeoutException());
      tryReconnect();
    });
  }

  onHandshake(EngineIOPacket packet) {
    Map<String, dynamic> data = json.decode(packet.data);
    sid = data['sid'];
    pingInterval = new Duration(milliseconds: utils.convertToInteger(data['pingInterval']));
    pingTimeout = new Duration(milliseconds:  utils.convertToInteger(data['pingTimeout']));
    if(readyStatus == EngineIOSocketStatus.OPENING) {
      _eventController.add(new EngineIOSocketEvent(EngineIOSocketEventType.OPEN));
    }
    onOpen();
    setPing();
  }

  onError(e) {
//    if(socket.readyState == WebSocket.CLOSING || socket.readyState == WebSocket.CLOSED) {
//      tryReconnect();
//    }
    _eventController.add(new EngineIOSocketEvent(EngineIOSocketEventType.ERROR, e));
  }

}