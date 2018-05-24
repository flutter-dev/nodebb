import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/actions/actions.dart';
import 'package:nodebb/application/application.dart';

import 'package:nodebb/mutations/mutations.dart';
import 'package:nodebb/services/io_service.dart';
import 'package:nodebb/utils/utils.dart' as utils;
import 'package:nodebb/views/bookmarks_page.dart';
import 'package:nodebb/views/chat_page.dart';
import 'package:nodebb/views/comment_page.dart';
import 'package:nodebb/views/home_page.dart';
import 'package:nodebb/views/login_page.dart';
import 'package:nodebb/views/recent_views_page.dart';
import 'package:nodebb/views/register_page.dart';
import 'package:nodebb/views/search_user_page.dart';
import 'package:nodebb/views/topic_detail_page.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/views/user_info_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nodebb/widgets/animation_page_route.dart';
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

  final Map _routes = <String, dynamic>{};

  var unWatchRecentViews;

  Store<AppState> store = new Store<AppState>(state: new AppState(
      unreadInfo: new UnreadInfo(),
      notification: new NodeBBNotification(),
      topics: new ObservableMap.linked(),
      categories: new ObservableMap.linked(),
      users: new ObservableMap.linked(),
      rooms: new ObservableMap.linked(),
      shareStorage: ObservableMap.linked(),
      recentViews: new ObservableList<int>()
  ));

  bool hasSetupRoutes = false;

  StreamSubscription ioSub;

  @override
  void initState() { //initState不要使用async 这样会令initState后于build方法触发
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    Application.setup();

    Future.wait([
      store.dispatch(new FetchTopicsAction(start: 0, count: 19)),
      //store.dispatch(new LoginAction('tain335', 'haha12345'))
    ]).catchError((err) {
      print(err);
    });

    loadDefaultUser();

    willsWatch(()=> store.state.activeUser, () {
      resetIOService();
      loadRecentViews();
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

  void loadDefaultUser() {
    SharedPreferences.getInstance().then((prefs) {
      var username = prefs.get('username');
      var password = prefs.get('password');
      if(!utils.isEmpty(username) && !utils.isEmpty(password)) {
        store.dispatch(new LoginAction(username, password));
      }
    });
  }

  void loadRecentViews() {
    SharedPreferences.getInstance().then((prefs) {
      if(unWatchRecentViews != null) unWatchRecentViews();
      Map userInfo = jsonDecode(prefs.get('user_${store.state.activeUser?.uid}') ?? '{}');
      List recentViews = userInfo['recentViews'] ?? [];
      store.state.recentViews.clear();
      store.state.recentViews.addAll(recentViews.cast<int>());
      unWatchRecentViews = willsWatch(()=> store.state.recentViews.length, () {
        userInfo['recentViews'] = store.state.recentViews.toList();
        prefs.setString('user_${store.state.activeUser?.uid}', jsonEncode(userInfo));
      });
    });
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
          Map data = event.data;
          String type = data['type'];
          switch(type) {
            case 'new-reply':
              store.commit(new UpdateNotificationMutation(newReply: true));
              break;
            case 'new-chat':
              store.commit(new UpdateNotificationMutation(newChat: true));
              break;
            case 'follow':
              store.commit(new UpdateNotificationMutation(newFollow: true));
              break;
            case 'group-invite':
              store.commit(new UpdateNotificationMutation(groupInvite: true));
              break;
            case 'new-topic':
              store.commit(new UpdateNotificationMutation(newTopic: true));
              break;
          }
          break;
        case NodeBBEventType.UPDATE_UNREAD_CHAT_COUNT:
          store.commit(new UpdateUnreadChatCountMutation(utils.convertToInteger(event.data)));
          break;
        case NodeBBEventType.MARKED_AS_READ:
          store.commit(new UpdateRoomUnreadStatusMutation(utils.convertToInteger(event.data['roomId']), false));
          break;
        case NodeBBEventType.RECEIVE_CHATS:
          Map data = event.data;
          var roomId = utils.convertToInteger(data['roomId']);
          if(store.state.rooms[roomId] != null) {
            store.commit(new UpdateRoomTeaserContentMutation(
                roomId,
                data['message']['cleanedContent'])
            );
            store.commit(new UpdateRoomUnreadStatusMutation(roomId, true));
          } else {
            store.dispatch(new FetchRecentChatAction());
          }
          break;
        case NodeBBEventType.UPDATE_NOTIFICATION_COUNT:
          break;
        case NodeBBEventType.NEW_TOPIC:
          store.commit(new UpdateNotificationMutation(newTopic: true));
          break;
        case NodeBBEventType.NEW_POST:
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
      return new AnimationPageRoute(builder: (BuildContext context) {
        return new TopicDetailPage(routeParams: params);
      }, maintainState: true,slideTween: new Tween(begin: new Offset(1.0, 0.0),end:new Offset(0.0, 0.0)));
    });

    _addRoute('/login', (Map<String, String> params) {
      return new MaterialPageRoute(builder: (BuildContext context) {
        return new LoginPage();
      }, maintainState: false);
    });

    _addRoute('/register', (Map<String, String> params) {
      return new MaterialPageRoute(builder: (BuildContext context) {
        return new RegisterPage();
      }, maintainState: false);
    });

    _addRoute('/chat/:roomId', (Map<String, String> params) {
      return new MaterialPageRoute(builder: (BuildContext context) {
        return new ChatPage(routeParams: params);
      }, maintainState: false);
    });

    _addRoute('/comment/:tid', (Map<String, String> params) {
      return new MaterialPageRoute(builder: (BuildContext context) {
        return new CommentPage(routeParams: params);
      }, maintainState: false);
    });

    _addRoute('/bookmarks', (Map<String, String> params) {
      return new MaterialPageRoute(builder: (BuildContext context) {
        return new BookmarksPage(routeParams: params);
      }, maintainState: false);
    });

    _addRoute('/search_user', (Map<String, String> params) {
      return new MaterialPageRoute(builder: (BuildContext context) {
        return new SearchUserPage(routeParams: params);
      });
    });

    _addRoute('/users/:uid', (Map<String, String> params) {
      return new MaterialPageRoute(builder: (BuildContext context) {
        return new UserInfoPage(routeParams: params);
      });
    });

    _addRoute('/recent_views', (Map<String, String> params) {
      return new MaterialPageRoute(builder: (BuildContext context) {
        return new RecentViewsPage(routeParams: params);
      });
    });

//    _addRoute('/about', (Map<String, String> params) {
//      return new MaterialPageRoute(builder: (BuildContext context) {
//
//      });
//    });
  }

  void _addRoute(path, routeBuilder) {
    if(_routes[path] != null) {
      throw new Exception('Route path: $path has existed, please check');
    }
    _routes[path] = routeBuilder;
  }

  Route _generateRoute(RouteSettings settings) {
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
        theme: new ThemeData(platform: TargetPlatform.android, primaryColor: utils.parseColorFromStr('#333333')),
        initialRoute: '/',
        onGenerateRoute: _generateRoute,
      )
    );
  }
}
