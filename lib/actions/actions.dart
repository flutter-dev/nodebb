import 'dart:async';

import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/models/models.dart';
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
    var users = new List<User>();
    var topics = new List<Topic>();
    for(var topic in topicsFromData) {
      topics.add(new Topic.fromMap(topic));
      users.add(new User.fromMap(topic['user']));
    }
    $store.commit(new AddUsersMutation(users));
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
    User user = new User.fromMap(data);
    $store.commit(new SetActiveUserMutation(user));
    yield user;
  }
}
