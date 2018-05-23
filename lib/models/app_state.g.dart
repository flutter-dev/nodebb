// GENERATED CODE - DO NOT MODIFY BY HAND

part of app_state;

// **************************************************************************
// Generator: WillsGenerator
// **************************************************************************

class _$AppState extends AppState {
  User _activeUser;
  User get activeUser {
    $observe('activeUser');
    return _activeUser;
  }

  set activeUser(User activeUser) {
    if (activeUser == _activeUser) return;
    _activeUser = activeUser;
    $notify('activeUser');
  }

  UnreadInfo _unreadInfo;
  UnreadInfo get unreadInfo {
    $observe('unreadInfo');
    return _unreadInfo;
  }

  set unreadInfo(UnreadInfo unreadInfo) {
    if (unreadInfo == _unreadInfo) return;
    _unreadInfo = unreadInfo;
    $notify('unreadInfo');
  }

  NodeBBNotification _notification;
  NodeBBNotification get notification {
    $observe('notification');
    return _notification;
  }

  set notification(NodeBBNotification notification) {
    if (notification == _notification) return;
    _notification = notification;
    $notify('notification');
  }

  ObservableMap<int, Topic> _topics;
  ObservableMap<int, Topic> get topics {
    $observe('topics');
    return _topics;
  }

  set topics(ObservableMap<int, Topic> topics) {
    if (topics == _topics) return;
    _topics = topics;
    $notify('topics');
  }

  ObservableMap<int, Category> _categories;
  ObservableMap<int, Category> get categories {
    $observe('categories');
    return _categories;
  }

  set categories(ObservableMap<int, Category> categories) {
    if (categories == _categories) return;
    _categories = categories;
    $notify('categories');
  }

  ObservableMap<int, User> _users;
  ObservableMap<int, User> get users {
    $observe('users');
    return _users;
  }

  set users(ObservableMap<int, User> users) {
    if (users == _users) return;
    _users = users;
    $notify('users');
  }

  ObservableMap<int, Room> _rooms;
  ObservableMap<int, Room> get rooms {
    $observe('rooms');
    return _rooms;
  }

  set rooms(ObservableMap<int, Room> rooms) {
    if (rooms == _rooms) return;
    _rooms = rooms;
    $notify('rooms');
  }

  ObservableMap<String, dynamic> _shareStorage;
  ObservableMap<String, dynamic> get shareStorage {
    $observe('shareStorage');
    return _shareStorage;
  }

  set shareStorage(ObservableMap<String, dynamic> shareStorage) {
    if (shareStorage == _shareStorage) return;
    _shareStorage = shareStorage;
    $notify('shareStorage');
  }

  ObservableList<int> _recentViews;
  ObservableList<int> get recentViews {
    $observe('recentViews');
    return _recentViews;
  }

  set recentViews(ObservableList<int> recentViews) {
    if (recentViews == _recentViews) return;
    _recentViews = recentViews;
    $notify('recentViews');
  }

  _$AppState.$() : super.$();
  factory _$AppState({
    User activeUser,
    UnreadInfo unreadInfo,
    NodeBBNotification notification,
    ObservableMap<int, Topic> topics,
    ObservableMap<int, Category> categories,
    ObservableMap<int, User> users,
    ObservableMap<int, Room> rooms,
    ObservableMap<String, dynamic> shareStorage,
    ObservableList<int> recentViews,
  }) {
    return new _$AppState.$()
      .._activeUser = activeUser
      .._unreadInfo = unreadInfo
      .._notification = notification
      .._topics = topics
      .._categories = categories
      .._users = users
      .._rooms = rooms
      .._shareStorage = shareStorage
      .._recentViews = recentViews;
  }
}
