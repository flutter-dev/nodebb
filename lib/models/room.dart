library room;

import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/models/message.dart';
import 'package:nodebb/models/teaser.dart';
import 'package:flutter_wills_gen/wills.dart';
import 'package:nodebb/models/user.dart';

part 'room.g.dart';

@wills
class Room extends Object with Reactive {

  int owner;

  int roomId;

  String roomName;

  ObservableList<User> users;

  bool groupChat;

  bool unread;

  String ownerName;

  Teaser teaser;

  int maxChatMessageLength;

  ObservableList<Message> messages;

  Room.$();

  factory Room.fromJson(Map json) {
    List datas = json['users'];
    ObservableList<User> users = new ObservableList();
    for(var data in datas) {
      users.add(new User.fromJson(data));
    }
    Room room = new _$Room(
      owner: json['owner'],
      roomId: json['roomId'],
      roomName: json['roomName'],
      ownerName: json['usernames'],
      groupChat: json['groupChat'],
      unread: json['unread'],
      users: users,
      maxChatMessageLength: json['maximumChatMessageLength'] ?? 1000,
      teaser: new Teaser.fromJson(json['teaser']),
      messages: new ObservableList()
    );
    return room;
  }

  factory Room() = _$Room;

}