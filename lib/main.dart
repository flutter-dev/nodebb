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

GlobalKey<_AppState> app = new GlobalKey();

void main() {
  runApp(new App(key: app));
}

class App extends StatefulWidget {

  App({Key key}): super(key: key);

  @override
  State createState() {
    return new _AppState();
  }

}

class _AppState extends State<App> with WidgetsBindingObserver {

  final Map _routes = {};

  Store<AppState> store = new Store<AppState>(state: new AppState(
      unreadInfo: new UnreadInfo(),
      topics: new ObservableMap.linked(),
      categories: new ObservableMap.linked(),
      users: new ObservableMap.linked(),
      rooms: new ObservableMap.linked()
  ));

  bool hasSetupRoutes = false;

  StreamSubscription ioSub;

  @override
  void initState() { //initState不要使用async 这样会令initState后于build方法触发
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    Application.setup();

    Future.wait([
      store.dispatch(new FetchTopicsAction()),
      store.dispatch(new LoginAction('tain335', 'haha12345'))
    ]).catchError((err) {
      print(err);
    });

    willsWatch(()=> store.state.activeUser, () {
      resetIOService();
    });
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state) {
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.resumed:
        resetIOService();
        break;
      default:
        break;
    }
  }

  void resetIOService() {
    ioSub?.cancel();
    IOService.getInstance().reset();
    connectIOService();
  }

  void connectIOService() async {
    await IOService.getInstance().connect();
    if(store.state.activeUser != null) {
      store.dispatch(new FetchUnreadInfoAction());
      store.dispatch(new FetchRecentChatAction());
    }
    ioSub = IOService.getInstance().eventStream.listen(null)..onData((NodeBBEvent event) {
      switch(event.type) {
        case NodeBBEventType.NEW_NOTIFICATION:
          break;
        case NodeBBEventType.UPDATE_UNREAD_CHAT_COUNT:
          store.commit(new UpdateUnreadChatCountMutation(utils.convertToInteger(event.data)));
          break;
        case NodeBBEventType.MARKED_AS_READ:
          store.commit(new UpdateRoomUnreadStatusMutation(utils.convertToInteger(event.data['roomId']), false));
          break;
        case NodeBBEventType.RECEIVE_CHATS:
          Map data = event.data;
          store.commit(new UpdateRoomTeaserContentMutation(
            utils.convertToInteger(data['roomId']),
            data['message']['cleanedContent'])
          );
          store.commit(new UpdateRoomUnreadStatusMutation(
              utils.convertToInteger(data['roomId']), true));
          break;
        case NodeBBEventType.UPDATE_NOTIFICATION_COUNT:
          break;
      }
      event.ack();
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
        return new ChatPage(routeParams: params);
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
