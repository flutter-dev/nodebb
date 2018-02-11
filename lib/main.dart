import 'package:built_redux/built_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';
import 'package:nodebb/actions/actions.dart';
import 'package:nodebb/middleware/middleware.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/reducers/reducers.dart';
import 'package:nodebb/services/remote_service.dart';
import 'package:nodebb/views/HomePage.dart';
import 'package:nodebb/views/TopicDetailPage.dart';
import 'package:nodebb/utils/utils.dart' as utils;

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

  final store = new Store<AppState, AppStateBuilder, AppActions>(
    reducerBuilder.build(),
    new AppState(),
    new AppActions(),
    middleware: [
      createAppStoreMiddleware()
    ]
  );

  final Map _routes = {};

  @override
  void initState() {
    _addRoute('/topic/:tid', (Map<String, String> params) {
      return new MaterialPageRoute(builder: (BuildContext context) {
        return new TopicDetailPage(routeParams: params);
      });
    });
    RemoteService.getInstance()..setup('172.18.4.75:4567');
    store.actions.fetchTopics();
  }

  void _addRoute(path, routeBuilder) {
    if(_routes[path] != null) {
      throw new Exception('Route path ${path} has existed, please check');
    }
    _routes[path] = routeBuilder;
  }

  Route<Null> _generateRoute(RouteSettings settings) {
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
      store: store,
      child: new MaterialApp(
        title: APP_TITLE,
        theme: new ThemeData.light(),
        home: new HomePage(title: APP_TITLE),
        onGenerateRoute: _generateRoute,
      )
    );
  }
}


//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => new _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  String content = '';
//
//  void initState() {
//    WebSocket.connect('ws://flutter-dev.cn/bbs/socket.io/?EIO=3&transport=websocket').then((socket) {
//      socket.listen((data) {
//        print(data);
//      });
//    });
//    http.get('http://172.18.4.75:4567/api/mobile/v1/topics/5').then((res) {
//      setState(() {
//        Map data = JSON.decode(res.body);
//        //List posts = data['posts'];
//        content = data['posts'].first['content'];
//      });
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text(widget.title),
//      ),
//      body: new Markdown(data: content),
////      body: new Center(
////        child: new Column(
////          mainAxisAlignment: MainAxisAlignment.center,
////          children: <Widget>[
////            const MarkdownBody(data: '![Flutter logo](https://flutter.io/images/flutter-mark-square-100.png#100x100)')
////          ],
////        ),
////      ),
//      floatingActionButton: new FloatingActionButton(
//        onPressed: () {},
//        tooltip: 'Increment',
//        child: new Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//}
