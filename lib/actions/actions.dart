import 'dart:async';

import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/mutations/mutations.dart';
import 'package:nodebb/services/io_service.dart';
import 'package:nodebb/services/remote_service.dart';

abstract class BaseRunLastAction<S> extends WillsRunLastAction<Store<AppState>, S> {}

abstract class BaseRunUniqueAction<S> extends WillsRunUniqueAction<Store<AppState>, S> {}

class FetchTopicsAction extends BaseRunLastAction {

  @override
  Stream exec() async* {
    var data;
    yield data = await RemoteService.getInstance().fetchTopics();
    yield data;
    List topicsFromData = data['topics'] ?? [];
    var topics = new List<Topic>();
    for(var topic in topicsFromData) {
      topics.add(new Topic.fromJson(topic));
    }
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
