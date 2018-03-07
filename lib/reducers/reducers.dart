import '../models/models.dart';
import 'package:built_redux/built_redux.dart';
import 'package:nodebb/actions/actions.dart';

var reducerBuilder = new ReducerBuilder<AppState, AppStateBuilder>()
  ..add(AppActionsNames.addTopics, addTopics)
  ..add(AppActionsNames.addUsers, addUsers)
  ..add(AppActionsNames.addPosts, addPosts)
  ..add(AppActionsNames.updateFetchTopicStatus, updateFetchTopicStatus)
  ..add(AppActionsNames.updateFetchTopicDetailStatus, updateFetchTopicDetailStatus)
  ..add(AppActionsNames.setActiveUser, setActiveUser);


void addTopics(AppState state, Action<List<Topic>> action, AppStateBuilder builder) {
  action.payload.forEach((topic) {
    applyCollectionAdd(builder.topics, topic.tid, topic);
  });
}

void addUsers(AppState state, Action<List<User>> action, AppStateBuilder builder) {
  action.payload.forEach((user) {
    applyCollectionAdd(builder.users, user.uid, user);
  });
}

void addPosts(AppState state, Action<List<Post>> action, AppStateBuilder builder) {
  List<Post> posts = action.payload;

  applyCollectionUpdate(builder.topics, posts?.elementAt(0)?.tid, (TopicBuilder b) {
    b.posts.clear();
    posts.forEach((post) {
      b.posts.add(post.pid);
    });
  });

  posts?.forEach((post) {
    applyCollectionAdd(builder.posts, post.pid, post);
  });
}

void setActiveUser(AppState state, Action<User> action, AppStateBuilder builder) {
  builder.activeUser = action.payload.uid;
  applyCollectionAdd(builder.users, action.payload.uid, action.payload);
}

void updateFetchTopicStatus(AppState state, Action<RequestStatus> action, AppStateBuilder builder) {
  builder.fetchTopicStatus = action.payload.toBuilder();
}

void updateFetchTopicDetailStatus(AppState state, Action<RequestStatus> action, AppStateBuilder builder) {
  builder.fetchTopicDetailStatus = action.payload.toBuilder();
}