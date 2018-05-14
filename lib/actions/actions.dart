import 'dart:async';

import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/mutations/mutations.dart';
import 'package:nodebb/services/io_service.dart';
import 'package:nodebb/services/remote_service.dart';

abstract class BaseAction<S> extends WillsAction<Store<AppState>, S> {}

abstract class BaseRunLastAction<S> extends WillsRunLastAction<Store<AppState>, S> {}

abstract class BaseRunUniqueAction<S> extends WillsRunUniqueAction<Store<AppState>, S> {}

abstract class BaseRunQueueAction<S> extends WillsRunQueueAction<Store<AppState>, S> {}

class FetchTopicsAction extends BaseRunLastAction {

  int start;

  int count;

  bool clearBefore;

  FetchTopicsAction({this.start = 0, this.count = 20, this.clearBefore = false});

  @override
  Stream exec() async* {
    var data;
    yield data = await RemoteService.getInstance().fetchTopics(start, count);
    yield data;
    List topicsFromData = data['topics'] ?? [];
    var topics = new List<Topic>();
    for(var topic in topicsFromData) {
      topics.add(new Topic.fromJson(topic));
    }
    if(clearBefore) {
      $store.commit(new ClearTopicsMutation());
    }
    $store.commit(new AddTopicsMutation(topics));
    yield topics;
  }

}


class LoginAction extends BaseRunUniqueAction<User> {

  String username;

  String password;

  LoginAction(this.username, this.password);

  @override
  Stream exec() async* {
    var data;
    yield data = await RemoteService.getInstance().doLogin(username, password);
    yield data;
    User user = new User.fromJson(data);
    $store.commit(new SetActiveUserMutation(user));
    yield user;
  }
}

class LogoutAction extends BaseRunUniqueAction<Null> {

  @override
  Stream exec() async* {
    yield await RemoteService.getInstance().doLogout();
    yield null;
    $store.commit(new SetActiveUserMutation(null));
  }

}

class FetchUnreadInfoAction extends BaseRunLastAction {

  @override
  Stream exec() async* {
    UnreadInfo info;
    yield info = await IOService.getInstance().getUserUnreadCounts();
    yield info;
    $store.commit(new SetUnreadInfoMutation(info));
  }

}

class FetchRecentChatAction extends BaseRunLastAction {

  @override
  Stream exec() async* {
    Map data;
    yield data = await IOService.getInstance().getRecentChat(uid: $store.state.activeUser.uid, after: 0);
    yield data;
    //nextStart = data['nextStart'];
    $store.commit(new AddRoomsMutation(data['rooms']));
  }

}

class PostCommentAction extends BaseAction<Post> {

  int topicId;

  int postId;

  String comment;

  PostCommentAction({this.topicId, this.postId, this.comment});

  @override
  Stream exec() async* {
    Post post;
    yield post = await IOService.getInstance().reply(topicId: topicId, postId: postId, content: comment);
    yield post;
  }

}

class DoBookmarkAction extends BaseAction<Map> {

  int topicId;

  int postId;

  DoBookmarkAction({this.topicId, this.postId});

  @override
  Stream exec() async* {
    var data;
    yield data = await IOService.getInstance().bookmark(topicId: topicId, postId: postId);
    yield data;
  }

}
