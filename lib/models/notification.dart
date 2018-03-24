library notification;

import 'package:flutter_wills/flutter_wills.dart';
import 'package:flutter_wills_gen/wills.dart';


part 'notification.g.dart';

@wills
class NodeBBNotification extends Object with Reactive {

  bool newReply;

  bool newChat;

  bool newFollow;

  bool groupInvite;

  bool newTopic;

  NodeBBNotification.$();

  factory NodeBBNotification() = _$NodeBBNotification;
}