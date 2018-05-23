// GENERATED CODE - DO NOT MODIFY BY HAND

part of unread_info;

// **************************************************************************
// Generator: WillsGenerator
// **************************************************************************

class _$UnreadInfo extends UnreadInfo {
  int _unreadTopicCount;
  int get unreadTopicCount {
    $observe('unreadTopicCount');
    return _unreadTopicCount;
  }

  set unreadTopicCount(int unreadTopicCount) {
    if (unreadTopicCount == _unreadTopicCount) return;
    _unreadTopicCount = unreadTopicCount;
    $notify('unreadTopicCount');
  }

  int _unreadNewTopicCount;
  int get unreadNewTopicCount {
    $observe('unreadNewTopicCount');
    return _unreadNewTopicCount;
  }

  set unreadNewTopicCount(int unreadNewTopicCount) {
    if (unreadNewTopicCount == _unreadNewTopicCount) return;
    _unreadNewTopicCount = unreadNewTopicCount;
    $notify('unreadNewTopicCount');
  }

  int _unreadChatCount;
  int get unreadChatCount {
    $observe('unreadChatCount');
    return _unreadChatCount;
  }

  set unreadChatCount(int unreadChatCount) {
    if (unreadChatCount == _unreadChatCount) return;
    _unreadChatCount = unreadChatCount;
    $notify('unreadChatCount');
  }

  int _unreadWatchedTopicCount;
  int get unreadWatchedTopicCount {
    $observe('unreadWatchedTopicCount');
    return _unreadWatchedTopicCount;
  }

  set unreadWatchedTopicCount(int unreadWatchedTopicCount) {
    if (unreadWatchedTopicCount == _unreadWatchedTopicCount) return;
    _unreadWatchedTopicCount = unreadWatchedTopicCount;
    $notify('unreadWatchedTopicCount');
  }

  int _unreadNotificationCount;
  int get unreadNotificationCount {
    $observe('unreadNotificationCount');
    return _unreadNotificationCount;
  }

  set unreadNotificationCount(int unreadNotificationCount) {
    if (unreadNotificationCount == _unreadNotificationCount) return;
    _unreadNotificationCount = unreadNotificationCount;
    $notify('unreadNotificationCount');
  }

  _$UnreadInfo.$() : super.$();
  factory _$UnreadInfo({
    int unreadTopicCount,
    int unreadNewTopicCount,
    int unreadChatCount,
    int unreadWatchedTopicCount,
    int unreadNotificationCount,
  }) {
    return new _$UnreadInfo.$()
      .._unreadTopicCount = unreadTopicCount ?? 0
      .._unreadNewTopicCount = unreadNewTopicCount ?? 0
      .._unreadChatCount = unreadChatCount ?? 0
      .._unreadWatchedTopicCount = unreadWatchedTopicCount ?? 0
      .._unreadNotificationCount = unreadNotificationCount ?? 0;
  }
}
