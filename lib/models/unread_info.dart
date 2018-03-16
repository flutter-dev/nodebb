library unread_info;

import 'package:flutter_wills/flutter_wills.dart';
import 'package:flutter_wills_gen/wills.dart';

part 'unread_info.g.dart';

@wills
class UnreadInfo extends Object with Reactive {

  int unreadTopicCount;

  int unreadNewTopicCount;

  int unreadChatCount;

  int unreadWatchedTopicCount;

  int unreadNotificationCount;

  UnreadInfo.$();

  factory UnreadInfo({
    int unreadTopicCount,
    int unreadNewTopicCount,
    int unreadChatCount,
    int unreadWatchedTopicCount,
    int unreadNotificationCount
  }) = _$UnreadInfo;
}