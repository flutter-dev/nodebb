library message;

import 'package:flutter_wills/flutter_wills.dart';
import 'package:flutter_wills_gen/wills.dart';
import 'package:nodebb/models/user.dart';

part 'message.g.dart';

enum MessageType { SEND, RECEIVE }

@wills
class Message extends Object with Reactive {

  User user;

  DateTime timestamp;

  String content;

  MessageType type;

  Message.$();
  
  factory Message.fromJson(Map json) {
    Message msg = new _$Message(
      user: new User.fromJson(json['fromUser']),
      timestamp: new DateTime.fromMicrosecondsSinceEpoch(json['timestamp']),
      content: json['cleanedContent'],
      type: MessageType.RECEIVE
    );
    return msg;
  }

  factory Message({User user, DateTime timestamp, String content, MessageType type}) = _$Message;

}