import 'dart:async';

import 'package:nodebb/application/application.dart';
import 'package:nodebb/socket_io/eio_parser.dart';
import 'package:nodebb/socket_io/eio_socket.dart';
import 'package:nodebb/socket_io/errors.dart';
import 'package:nodebb/socket_io/sio_client.dart';
import 'package:nodebb/socket_io/sio_parser.dart';
import 'package:nodebb/utils/utils.dart' as utils;


enum SocketIOSocketEventType {
  CONNECT,
  CONNECT_ERROR,
  CONNECT_TIMEOUT,
  CONNECTING,
  DISCONNECT,
  ERROR,
  RECONNECT,
  RECONNECT_ATTEMPT,
  RECONNECT_FAIL,
  RECONNECTING,
  PING,
  PONG,
  //自定义事件
  SEND,
  RECEIVE,
  CLOSE
}

class SocketIOSocketEvent {

  SocketIOSocketEventType type;

  dynamic data;

  AckHandler ack;

  SocketIOSocketEvent(this.type, [this.data, this.ack]);

  @override
  String toString() {
    return '{type: $type, data: $data}';
  }
}

typedef OnAckHandler(SocketIOPacket packet);

typedef AckHandler();

class SocketIOSocket {

  SocketIOClient owner;

  String namespace;

  bool ready = false;

  EngineIOSocket io;

  List<SocketIOPacket> sendBuffer = new List();

  List<SocketIOPacket> receiveBuffer = new List();

  SocketIOPacketDecoder decoder = new SocketIOPacketDecoder();

  SocketIOPacketEncoder encoder = new SocketIOPacketEncoder();

  Map<String, String> query;

  Map<int, OnAckHandler> acks = new Map();

  int ids = 0;

  StreamSubscription<EngineIOSocketEvent> _sub;

  StreamController<SocketIOSocketEvent> _eventController = new StreamController.broadcast();

  Stream<SocketIOSocketEvent> get  eventStream => _eventController.stream;

  SocketIOSocket({this.io, this.namespace = '/', this.owner, this.query}) {
    _eventController.add(new SocketIOSocketEvent(SocketIOSocketEventType.CONNECTING));
    if(io.readyStatus == EngineIOSocketStatus.OPEN) {
      onOpen();
    }
    setupEvents();
  }

  setupEvents() {
    Application.logger.fine('socketio namespace: $namespace listen socket: ${io.sid}');
    _sub = this.io.eventStream.listen(null)..onData((EngineIOSocketEvent e) {
      if(e.type == EngineIOSocketEventType.ERROR) {
        onError(e.data);
        return;
      }
      switch(e.type) {
        case EngineIOSocketEventType.OPEN:
          onOpen();
          break;
        case EngineIOSocketEventType.FLUSH:
          break;
        case EngineIOSocketEventType.RECEIVE:
          if(e.data != null && e.data.type == EngineIOPacketType.MESSAGE) {
            SocketIOPacket p = decoder.convert(e.data);
            Application.logger.fine('receive socketio packet $p');
            if (p?.namespace != namespace) return; //not match
            onPacket(p);
          }
          break;
        case EngineIOSocketEventType.SEND:
          break;
        case EngineIOSocketEventType.CLOSE:
          onClose();
          break;
        default:
          break;
      }
    });
  }

  teardownEvents() {
    _sub?.cancel();
  }

  onPacket(SocketIOPacket packet) {
    switch(packet.type) {
      case SocketIOPacketType.ERROR:
        onError(packet);
        break;
      case SocketIOPacketType.BINARY_EVENT:
        onEvent(packet);
        break;
      case SocketIOPacketType.BINARY_ACK:
        onAck(packet);
        break;
      case SocketIOPacketType.ACK:
        onAck(packet);
        break;
      case SocketIOPacketType.CONNECT:
        onConnect(packet);
        break;
      case SocketIOPacketType.DISCONNECT:
        onDisconnect(packet);
        break;
      case SocketIOPacketType.EVENT:
        onEvent(packet);
        break;
    }
  }

  onOpen() {
    connect();
  }

  onClose() {
    ready = false;
    teardownEvents();
    _eventController.add(new SocketIOSocketEvent(SocketIOSocketEventType.DISCONNECT));
  }

  onError(e) {
    _eventController.add(new SocketIOSocketEvent(SocketIOSocketEventType.ERROR, e.data));
  }

  onEvent(SocketIOPacket packet) {
    bool sent = false;
    _eventController.add(new SocketIOSocketEvent(
        SocketIOSocketEventType.RECEIVE,
        packet,
        () {
          if(!sent && packet.id != null) {
            SocketIOPacketType type;
            if(packet.type == SocketIOPacketType.EVENT) {
              type = SocketIOPacketType.ACK;
            } else if(packet.type == SocketIOPacketType.BINARY_EVENT) {
              type = SocketIOPacketType.BINARY_ACK;
            }
            send(new SocketIOPacket(
              type: type,
              id: packet.id
            ));
            sent = true;
          }
        }
    ));
  }

  onAck(SocketIOPacket packet) {
    if(packet.id != null && acks[packet.id] != null) {
      Application.logger.fine('call ack ${packet.id} with ${packet.data}');
      acks[packet.id](packet);
      acks.remove(packet.id);
    } else {
      Application.logger.fine('bad ack ${packet.id}');
    }
  }

  onDisconnect(SocketIOPacket packet) {
    ready = false;
    _eventController.add(new SocketIOSocketEvent(
      SocketIOSocketEventType.DISCONNECT,
      packet
    ));
  }

  onConnect(SocketIOPacket packet) {
    ready = true;
    flush();
    _eventController.add(new SocketIOSocketEvent(
      SocketIOSocketEventType.CONNECT,
      packet
    ));
  }


  send(SocketIOPacket packet, [OnAckHandler handler]) {
    if(handler != null) {
      int id = ids++;
      acks[id] = handler;
      packet.id = id;
    }
    sendBuffer.add(packet);
    if(ready) flush();
  }

//  ack(SocketIOPacket packet) {
//    SocketIOPacketType type;
//    if(packet.type == SocketIOPacketType.EVENT) {
//      type = SocketIOPacketType.ACK;
//    } else if(packet.type == SocketIOPacketType.BINARY_EVENT) {
//      type = SocketIOPacketType.BINARY_ACK;
//    } else {
//      throw new SocketIOStateException('packet type must be SocketIOPacketType.EVENT or SocketIOPacketType.BINARY_EVENT');
//    }
//    if(packet.id == null) {
//      throw new SocketIOParseException('paket id not found');
//    }
//    Application.logger.fine('send socketio packet ack: ${packet.id}');
//    send(new SocketIOPacket(type: type, id: packet.id));
//  }

  _sendPacket(SocketIOPacket packet) {
    if(packet.namespace == null || packet.namespace == '') {
      packet.namespace = namespace;
    }
    _eventController.add(new SocketIOSocketEvent(SocketIOSocketEventType.SEND, packet));
    Application.logger.fine('send socketio packet $packet');
    encoder.convert(packet).forEach((EngineIOPacket p) {
      io.sendPacket(p);
    });
  }

  flush() {
    sendBuffer.forEach((SocketIOPacket packet) {
      _sendPacket(packet);
    });
    sendBuffer.clear();
  }

  connect() {
    if(io.readyStatus == EngineIOSocketStatus.OPEN) {
      if (namespace != '/') {
        if (query != null) {
          _sendPacket(new SocketIOPacket(
            type: SocketIOPacketType.CONNECT,
            namespace: namespace + '?' + utils.encodeUriQuery(query)
          ));
        } else {
          _sendPacket(new SocketIOPacket(
              type: SocketIOPacketType.CONNECT
          ));
        }
      }
    } else {
      throw new SocketIOStateException('io does not open before connect');
    }
  }

  disconnect() {
    if(this.ready) {
      this.send(new SocketIOPacket(type: SocketIOPacketType.DISCONNECT));
    }
  }

  close() {
    if(this.ready) {
      disconnect();
      eventStream
          .where((SocketIOSocketEvent event) {
        return event.type == SocketIOSocketEventType.DISCONNECT;
      }).listen((SocketIOSocketEvent event) {
        teardownEvents();
      });
    } else {
      teardownEvents();
    }
  }

  StreamSubscription listen({SocketIOSocketEventType type = SocketIOSocketEventType.RECEIVE,onData, onError, onDone}) {
    StreamSubscription ss;
    ss = eventStream
      .where((SocketIOSocketEvent event) {
        return event.type == type;
      }).listen(null)
      ..onData((data) {
        if(onData != null) {
          onData(data);
        }
      })..onError((err) {
        if(onError != null) {
          onError(err);
        }
      })..onDone(() {
        if(onDone != null) {
          onDone();
        }
      });
    return ss;
  }
}