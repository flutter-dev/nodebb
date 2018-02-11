import '../models/models.dart';
import 'package:built_redux/built_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nodebb/actions/actions.dart';
import 'package:built_collection/built_collection.dart';

var reducerBuilder = new ReducerBuilder<AppState, AppStateBuilder>()
  ..add(AppActionsNames.addTopics, addTopics)
  ..add(AppActionsNames.addUsers, addUsers)
  ..add(AppActionsNames.addPosts, addPosts);


void addTopics(AppState state, Action<List<Topic>> action, AppStateBuilder builder) {
  action.payload.forEach((topic) {
    state.topics.add(builder.topics, topic.tid, topic);
  });
}

void addUsers(AppState state, Action<List<User>> action, AppStateBuilder builder) {
  action.payload.forEach((user) {
    state.users.add(builder.users, user.uid, user);
  });
}

void addPosts(AppState state, Action<List<Post>> action, AppStateBuilder builder) {
  List<Post> posts = action.payload;

  state.topics.update(builder.topics, posts?.elementAt(0)?.tid, (TopicBuilder b) {
    b.posts.clear();
    posts.forEach((post) {
      b.posts.add(post.pid);
    });
  });

  posts?.forEach((post) {
    state.posts.add(builder.posts, post.pid, post);
  });
}