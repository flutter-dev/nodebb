import 'dart:async';

import 'package:nodebb/services/cookie_jar.dart';
import 'package:nodebb/socket_io/eio_client.dart';
import 'package:nodebb/socket_io/eio_socket.dart';
import 'package:nodebb/socket_io/sio_socket.dart';

class SocketIOEvent {}

class SocketIOClient {

  String uri;

  int connectTimeout;

  bool autoReconnect;

  int reconnectInterval;

  int maxReconnectTrys;

  CookieJar jar;

  List<SocketIOSocket> sockets = new List();

  //StreamController _eventController = new StreamController.broadcast();

  //StreamSubscription<EngineIOEvent> _sub;

  EngineIOClient engine;

  //Stream<SocketIOEvent> get  eventStream => _eventController.stream;

  SocketIOClient({
    this.uri,
    this.autoReconnect = true,
    this.reconnectInterval = 10000,
    this.maxReconnectTrys = 3,
    this.connectTimeout = 8000,
    this.jar
  }) {
    if(this.jar == null) {
      this.jar = new CookieJar();
    }
    engine = new EngineIOClient(
      autoReconnect: autoReconnect,
      reconnectInterval: reconnectInterval,
      maxReconnectTrys: maxReconnectTrys,
      jar: jar
    );
  }

  Future<SocketIOSocket> of({String namespace = '/', Map<String, String> query}) async {
     EngineIOSocket io = await engine.connect(uri, true);
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