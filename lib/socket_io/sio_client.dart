import 'dart:async';

import 'package:nodebb/socket_io/eio_client.dart';
import 'package:nodebb/socket_io/eio_socket.dart';
import 'package:nodebb/socket_io/sio_socket.dart';

class SocketIOEvent {}

class SocketIOClient {

  String uri;

  int connectTimeout;

  bool autoReconnect;

  int reconnectInterval;

  int maxReconnectTry;

  List<SocketIOSocket> sockets = new List();

  //StreamController _eventController = new StreamController.broadcast();

  //StreamSubscription<EngineIOEvent> _sub;

  EngineIOClient engine;

  //Stream<SocketIOEvent> get  eventStream => _eventController.stream;

  SocketIOClient({
    this.uri,
    this.autoReconnect = true,
    this.reconnectInterval = 10000,
    this.maxReconnectTry = 3,
    this.connectTimeout = 8000}) {
    engine = new EngineIOClient(
      autoReconnect: autoReconnect,
      reconnectInterval: reconnectInterval,
      maxReconnectTry: maxReconnectTry
    );
  }

  of({String namespace = '/', Map<String, String> query}) async {
     EngineIOSocket io = await this.engine.connect(uri);
     SocketIOSocket socket = new SocketIOSocket(
       io: io,
       namespace: namespace,
       query: query
     );
     sockets.add(socket);
     return socket;
  }

  closeAll() {
    engine.closeAll();
  }

}