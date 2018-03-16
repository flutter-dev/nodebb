// GENERATED CODE - DO NOT MODIFY BY HAND

part of unread_info;

// **************************************************************************
// Generator: WillsGenerator
// **************************************************************************

class _$UnreadInfo extends UnreadInfo {
  int _unreadTopicCount;
  int get unreadTopicCount {
    $observe('unreadTopicCount');
    _unreadTopicCount = _unreadTopicCount ?? 0;
    return _unreadTopicCount;
  }

  set unreadTopicCount(int unreadTopicCount) {
    if (unreadTopicCount != null && unreadTopicCount == _unreadTopicCount)
      return;
    _unreadTopicCount = unreadTopicCount;
    $notify('unreadTopicCount');
  }

  int _unreadNewTopicCount;
  int get unreadNewTopicCount {
    $observe('unreadNewTopicCount');
    _unreadNewTopicCount = _unreadNewTopicCount ?? 0;
    return _unreadNewTopicCount;
  }

  set unreadNewTopicCount(int unreadNewTopicCount) {
    if (unreadNewTopicCount != null &&
        unreadNewTopicCount == _unreadNewTopicCount) return;
    _unreadNewTopicCount = unreadNewTopicCount;
    $notify('unreadNewTopicCount');
  }

  int _unreadChatCount;
  int get unreadChatCount {
    $observe('unreadChatCount');
    _unreadChatCount = _unreadChatCount ?? 0;
    return _unreadChatCount;
  }

  set unreadChatCount(int unreadChatCount) {
    if (unreadChatCount != null && unreadChatCount == _unreadChatCount) return;
    _unreadChatCount = unreadChatCount;
    $notify('unreadChatCount');
  }

  int _unreadWatchedTopicCount;
  int get unreadWatchedTopicCount {
    $observe('unreadWatchedTopicCount');
    _unreadWatchedTopicCount = _unreadWatchedTopicCount ?? 0;
    return _unreadWatchedTopicCount;
  }

  set unreadWatchedTopicCount(int unreadWatchedTopicCount) {
    if (unreadWatchedTopicCount != null &&
        unreadWatchedTopicCount == _unreadWatchedTopicCount) return;
    _unreadWatchedTopicCount = unreadWatchedTopicCount;
    $notify('unreadWatchedTopicCount');
  }

  int _unreadNotificationCount;
  int get unreadNotificationCount {
    $observe('unreadNotificationCount');
    _unreadNotificationCount = _unreadNotificationCount ?? 0;
    return _unreadNotificationCount;
  }

  set unreadNotificationCount(int unreadNotificationCount) {
    if (unreadNotificationCount != null &&
        unreadNotificationCount == _unreadNotificationCount) return;
    _unreadNotificationCount = unreadNotificationCount;
    $notify('unreadNotificationCount');
  }

  _$UnreadInfo.$() : super.$();
  factory _$UnreadInfo({
    int unreadTopicCount: 0,
    int unreadNewTopicCount: 0,
    int unreadChatCount: 0,
    int unreadWatchedTopicCount: 0,
    int unreadNotificationCount: 0,
  }) {
    return new _$UnreadInfo.$()
      .._unreadTopicCount = unreadTopicCount
      .._unreadNewTopicCount = unreadNewTopicCount
      .._unreadChatCount = unreadChatCount
      .._unreadWatchedTopicCount = unreadWatchedTopicCount
      .._unreadNotificationCount = unreadNotificationCount;
  }
}
