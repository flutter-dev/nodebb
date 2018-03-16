import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/actions/actions.dart';
import 'package:nodebb/application/application.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/mutations/mutations.dart';
import 'package:nodebb/services/io_service.dart';
import 'package:nodebb/utils/utils.dart' as utils;
import 'package:nodebb/views/chat_page.dart';
import 'package:nodebb/views/home_page.dart';
import 'package:nodebb/views/login_page.dart';
import 'package:nodebb/views/register_page.dart';
import 'package:nodebb/views/topic_detail_page.dart';

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

  Store<AppState> store;

  bool hasSetupRoutes = false;

  @override
  void initState() { //initState不要使用async 这样会令initState后于build方法触发

    Application.setup();

    store = new Store<AppState>(state: new AppState(
      unreadInfo: new UnreadInfo(),
      topics: new ObservableMap.linked(),
      categories: new ObservableMap.linked(),
      users: new ObservableMap.linked(),
      rooms: new ObservableMap.linked()
    ));

    Future.wait([
      store.dispatch(new FetchTopicsAction()),
      store.dispatch(new LoginAction('tain335', 'haha12345'))
    ]).then((values) async {
      await IOService.getInstance().connect();
      store.dispatch(new FetchUnreadInfoAction());
      store.dispatch(new FetchRecentChatAction());
      //store.dispatch(new FetchTopicsAction()).then((_) async {


      //});
    }).catchError((err) {
      print(err);
    });
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

    _addRoute('/chat/:roomId', (Map<String, String> params) {
      return new MaterialPageRoute(builder: (BuildContext context) {
        return new ChatPage();
      });
    });
  }

  void _addRoute(path, routeBuilder) {
    if(_routes[path] != null) {
      throw new Exception('Route path: $path has existed, please check');
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
    return new WillsProvider(
        store: store,
        child: new MaterialApp(
          title: APP_TITLE,
          theme: new ThemeData.light(),
          initialRoute: '/',
          onGenerateRoute: _generateRoute,
        )
    );
  }
}
