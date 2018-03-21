import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/models/room.dart';

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
    $store.commit(new SetUnreadInfoMutation(new UnreadInfo()));
    $store.commit(new ClearRoomsMutation());
  }

}

class AddRoomsMutation extends BaseMutation {

  List<Room> rooms;

  AddRoomsMutation(this.rooms);

  @override
  exec() {
    rooms.forEach((room) {
      $store.state.rooms[room.roomId] = room;
    });
  }

}

class SetUnreadInfoMutation extends BaseMutation {

  UnreadInfo info;

  SetUnreadInfoMutation(this.info);

  @override
  exec() {
    $store.state.unreadInfo = info;
  }

}

class AddMessagesToRoomMutation extends BaseMutation {

  List<Message> messages;

  int roomId;

  AddMessagesToRoomMutation(this.roomId, this.messages);

  @override
  exec() {
    $store.state.rooms[roomId].messages.addAll(messages);
  }


}

class ClearMessagesFromRoomMutation extends BaseMutation {

  int roomId;

  ClearMessagesFromRoomMutation(this.roomId);

  @override
  exec() {
    $store.state.rooms[roomId]?.messages?.clear();
  }

}

class ClearRoomsMutation extends BaseMutation {

  ClearRoomsMutation();

  @override
  exec() {
    $store.state.rooms.clear();
  }

}

class UpdateUnreadChatCountMutation extends BaseMutation {

  int unreadChatCount = 0;

  UpdateUnreadChatCountMutation(this.unreadChatCount);

  @override
  exec() {
    $store.state.unreadInfo.unreadChatCount = unreadChatCount;
  }

}

class UpdateRoomUnreadStatusMutation extends BaseMutation {

  bool unread;

  int roomId;

  UpdateRoomUnreadStatusMutation(this.roomId, this.unread);

  @override
  exec() {
    $store.state.rooms[this.roomId].unread = unread;
  }

}

class UpdateRoomTeaserContentMutation extends BaseMutation {

  int roomId;

  String content;

  UpdateRoomTeaserContentMutation(this.roomId, this.content);

  @override
  exec() {
    Room room = $store.state.rooms[this.roomId];
    if(room != null) {
      room.teaser.content = content;
    }
  }

}