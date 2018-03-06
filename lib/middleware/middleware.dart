import 'package:built_redux/built_redux.dart';
import 'package:nodebb/actions/actions.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/services/remote_service.dart';



Middleware<AppState, AppStateBuilder, AppActions> createAppStoreMiddleware() {
  return (new MiddlewareBuilder<AppState, AppStateBuilder, AppActions>()
        ..add(AppActionsNames.fetchTopics, createFetchTopics())
        ..add(AppActionsNames.fetchTopicDetail, createFetchTopicDetail())).build();

}

class _SafeLock {
  int semaphore = 0;
  get() {
    int internalSemaphore = ++semaphore;
    return (proc) {
      if(internalSemaphore == semaphore) {
        proc();
      }
    };
  }
}

MiddlewareHandler _runLast(middleware) {
  _SafeLock lock = new _SafeLock();
  return (api, next, action) {
    var dispatch = lock.get();
    middleware(api, next, action, dispatch);
  };
}

MiddlewareHandler<AppState, AppStateBuilder, AppActions, Null> createFetchTopics() { //redux-thunk style
  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
        ActionHandler next, Action<Null> action) async {
    if(isRequestResolved(api.state.fetchTopicStatus.status)) {
      api.actions.updateFetchTopicStatus(api.state.fetchTopicStatus.rebuild((builder) {
        builder.status = $RequestStatus.PENDING;
      }));
    } else {
      return;
    }
    try {
      var data = await RemoteService.getInstance().fetchTopics();
      List topicsFromData = data['topics'] ?? [];
      var topics = new List<Topic>();
      var users = new List<User>();
      for(var topic in topicsFromData) {
        topics.add(new Topic.fromMap(topic));
        users.add(new User.fromMap(topic['user']));
      }
      api.actions.addTopics(topics);
      api.actions.addUsers(users);
      api.actions.updateFetchTopicStatus(api.state.fetchTopicStatus.rebuild((builder) {
        builder.status = $RequestStatus.SUCCESS;
      }));
    } catch(e) {
      api.actions.updateFetchTopicStatus(api.state.fetchTopicStatus.rebuild((builder) {
        builder.status = $RequestStatus.ERROR;
        builder.exception = new Exception(e);
      }));
    }
  };
}

MiddlewareHandler<AppState, AppStateBuilder, AppActions, int> createFetchTopicDetail() {
  return _runLast((MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
      ActionHandler next, Action<int> action, dispatch) async {
    dispatch(() {
      api.actions.updateFetchTopicDetailStatus(api.state.fetchTopicDetailStatus.rebuild((builder) {
        builder.status = $RequestStatus.PENDING;
      }));
    });
    try {
      var data = await RemoteService.getInstance()
          .fetchTopicDetail(action.payload);
      dispatch(() {
        var posts = new List<Post>();
        List postsFromData = data['posts'] ?? [];
        for (var post in postsFromData) {
          posts.add(new Post.fromMap(post));
        }
        api.actions.addPosts(posts);
        api.actions.updateFetchTopicDetailStatus(api.state.fetchTopicDetailStatus.rebuild((builder) {
          builder.status = $RequestStatus.SUCCESS;
        }));
      });
    } catch(e) {
      dispatch(() {
        api.actions.updateFetchTopicDetailStatus(api.state.fetchTopicDetailStatus.rebuild((builder) {
          builder.status = $RequestStatus.ERROR;
          builder.exception = new Exception(e);
        }));
      });
    }
  });
}


MiddlewareHandler<AppState, AppStateBuilder, AppActions, int> createFetchUser() {
  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
      ActionHandler next, Action<int> action) async {
    if(isRequestResolved(api.state.fetchUserStatus.status)) {
      api.actions.updateFetchTopicStatus(api.state.fetchUserStatus.rebuild((builder) {
        builder.status = $RequestStatus.PENDING;
      }));
    } else {
      return;
    }
  };
}