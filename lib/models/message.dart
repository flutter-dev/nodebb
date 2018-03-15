library message;

import 'package:flutter_wills/flutter_wills.dart';
import 'package:flutter_wills_gen/wills.dart';
import 'package:nodebb/models/user.dart';

part 'message.g.dart';

enum MessageType { SEND, RECEIVE }

@wills
class Message extends Object with Reactive {

  User user;

  DateTime createdTime;

  String content;

  MessageType type;

  Message.$();

  factory Message({User user, DateTime createdTime, String content, MessageType type}) = _$Message;

}