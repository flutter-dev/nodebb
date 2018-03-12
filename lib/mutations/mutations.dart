import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/models/models.dart';

abstract class BaseMutation extends WillsMutation<Store<AppState>> {}

class AddUsersMutation extends BaseMutation {

  List<User> users;

  AddUsersMutation(this.users);

  @override
  exec() {
    users.forEach((user) {
      $store.state.users[user.uid] = user;
    });
  }

}

class AddTopicsMutation extends BaseMutation {

  List<Topic> topics;

  AddTopicsMutation(this.topics);

  @override
  exec() {
    topics.forEach((topic) {
      $store.state.topics[topic.tid] = topic;
    });
  }

}

class SetActiveUserMutation extends BaseMutation {

  User user;

  SetActiveUserMutation(this.user);

  @override
  exec() {
    $store.state.activeUser = user;
  }

}