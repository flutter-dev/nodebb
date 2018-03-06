import 'package:flutter/material.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';
import 'package:nodebb/services/remote_service.dart';
import 'package:nodebb/socket_io/socket_io.dart';
import 'package:nodebb/views/HomePage.dart';
import 'package:nodebb/views/LoginPage.dart';
import 'package:nodebb/views/RegisterPage.dart';
import 'package:nodebb/views/TopicDetailPage.dart';
import 'package:nodebb/utils/utils.dart' as utils;
import 'package:nodebb/application/application.dart';

//import 'dart:io';
//import 'package:http/http.dart' as http;
//import 'dart:convert';
//import 'package:flutter_markdown/flutter_markdown.dart';


const APP_TITLE = 'Flutter Dev';

void main() {
  runApp(new App());
}

class App extends StatefulWidget {


  @override
  State createState() {
    return new _AppState();
  }

}

class _AppState extends State<App> {

  final Map _routes = {};

  bool hasSetupRoutes = false;

  @override
  void initState() async {
    Application.setup();
    RemoteService.getInstance().setup(Application.host);
    Application.store.actions.fetchTopics();
    SocketIOClient client = new SocketIOClient(uri: 'ws://${Application.host}/socket.io/?EIO=3&transport=websocket');
    SocketIOSocket socket = await client.of();
  }


  void _setupRoutes() {
    _addRoute('/', (Map<String, String> params) {
      return new MaterialPageRoute(builder: (BuildContext context) {
        return new HomePage(title: APP_TITLE);
      });
    });

    _addRoute('/topic/:tid', (Map<String, String> params) {
      return new MaterialPageRoute(builder: (BuildContext context) {
        return new TopicDetailPage(routeParams: params);
      });
    });

    _addRoute('/login', (Map<String, String> params) {
      return new MaterialPageRoute(builder: (BuildContext context) {
        return new LoginPage();
      });
    });

    _addRoute('/register', (Map<String, String> params) {
      return new MaterialPageRoute(builder: (BuildContext context) {
        return new RegisterPage();
      });
    });
  }

  void _addRoute(path, routeBuilder) {
    if(_routes[path] != null) {
      throw new Exception('Route path ${path} has existed, please check');
    }
    _routes[path] = routeBuilder;
  }

  Route<Null> _generateRoute(RouteSettings settings) {
    if(!hasSetupRoutes) {
      _setupRoutes();
      hasSetupRoutes = true;
    }
    List<String> keys = _routes.keys.toList(growable: true);
    for(String key in keys) {
      Map<String, String> params = utils.pathMatcher(key, settings.name);
      if(params != null) {
        return _routes[key](params);
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new ReduxProvider(
      store: Application.store,
      child: new MaterialApp(
        title: APP_TITLE,
        theme: new ThemeData.light(),
        initialRoute: '/login',
        onGenerateRoute: _generateRoute,
      )
    );
  }
}
