library message;

import 'package:flutter_wills/flutter_wills.dart';
import 'package:flutter_wills_gen/wills.dart';
import 'package:nodebb/models/user.dart';

part 'message.g.dart';

enum MessageType { SEND, RECEIVE, SEND_PENDING }

@wills
class Message extends Object with Reactive {

  int id;

  User user;

  DateTime timestamp;

  String content;

  MessageType type;

  Message.$();
  
  factory Message({User user, DateTime timestamp, String content, MessageType type}) = _$Message;

  factory Message.fromJSON(Map json) {
    Message msg = new _$Message(
      id: json['messageId'],
      user: new User.fromJSON(json['fromUser']),
      timestamp: new DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
      content: json['cleanedContent'],
      type: MessageType.RECEIVE
    );
    return msg;
  }

}