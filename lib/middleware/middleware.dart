import 'package:built_redux/built_redux.dart';
import 'package:nodebb/actions/actions.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/services/remote_service.dart';

Middleware<AppState, AppStateBuilder, AppActions> createAppStoreMiddleware() {
  return (new MiddlewareBuilder<AppState, AppStateBuilder, AppActions>()
        ..add(AppActionsNames.fetchTopics, createFetchTopics())
        ..add(AppActionsNames.fetchTopicDetail, createFetchTopicDetail())).build();

}

MiddlewareHandler<AppState, AppStateBuilder, AppActions, Null> createFetchTopics() {
  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
        ActionHandler next, Action<Null> action) async {
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
  };
}

MiddlewareHandler<AppState, AppStateBuilder, AppActions, int> createFetchTopicDetail() {
  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
      ActionHandler next, Action<int> action) async {
    var data = await RemoteService.getInstance().fetchTopicDetail(action.payload);
    var posts = new List<Post>();
    List postsFromData = data['posts'] ?? [];
    for(var post in postsFromData) {
      posts.add(new Post.fromMap(post));
    }
    api.actions.addPosts(posts);
    //api.actions.addPosts();
    //api.actions.addTopicDetail();
  };
}