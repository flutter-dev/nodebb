import 'dart:async';

import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/models/room.dart';
import 'package:nodebb/services/io_service.dart';
import 'package:nodebb/services/remote_service.dart';
import 'package:nodebb/mutations/mutations.dart';

abstract class BaseRunLastAction<S> extends WillsRunLastAction<Store<AppState>, S> {}

abstract class BaseRunUniqueAction<S> extends WillsRunUniqueAction<Store<AppState>, S> {}

class FetchTopicsAction extends BaseRunLastAction<dynamic> {

  @override
  Stream exec() async* {
    var data;
    yield data = await RemoteService.getInstance().fetchTopics();
    List topicsFromData = data['topics'] ?? [];
    //var users = new List<User>();
    var topics = new List<Topic>();
    for(var topic in topicsFromData) {
      topics.add(new Topic.fromJson(topic));
      //users.add(new User.fromJson(topic['user']));
    }
    //$store.commit(new AddUsersMutation(users));
    $store.commit(new AddTopicsMutation(topics));
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
    User user = new User.fromJson(data);
    $store.commit(new SetActiveUserMutation(user));
    yield user;
  }
}

class LogoutAction extends BaseRunUniqueAction<Null> {

  @override
  Stream exec() async* {
    await RemoteService.getInstance().doLogout();
    $store.commit(new SetActiveUserMutation(null));
  }

}

class FetchUnreadInfoAction extends BaseRunLastAction<Null> {

  @override
  Stream exec() async* {
    UnreadInfo info = await IOService.getInstance().getUserUnreadCounts();
    $store.commit(new SetUnreadInfoMutation(info));
  }

}

class FetchRecentChatAction extends BaseRunLastAction<Null> {

  static int nextStart = 0;

  @override
  Stream exec() async* {
    Map data = await IOService.getInstance().getRecentChat(uid: $store.state.activeUser.uid, after: nextStart);
    nextStart = data['nextStart'];
    $store.commit(new AddRoomsMutation(data['rooms']));
  }

}
