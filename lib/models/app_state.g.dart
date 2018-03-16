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
    if (activeUser != null && activeUser == _activeUser) return;
    _activeUser = activeUser;
    $notify('activeUser');
  }

  UnreadInfo _unreadInfo;
  UnreadInfo get unreadInfo {
    $observe('unreadInfo');

    return _unreadInfo;
  }

  set unreadInfo(UnreadInfo unreadInfo) {
    if (unreadInfo != null && unreadInfo == _unreadInfo) return;
    _unreadInfo = unreadInfo;
    $notify('unreadInfo');
  }

  ObservableMap<int, Topic> _topics;
  ObservableMap<int, Topic> get topics {
    $observe('topics');

    return _topics;
  }

  set topics(ObservableMap<int, Topic> topics) {
    if (topics != null && topics == _topics) return;
    _topics = topics;
    $notify('topics');
  }

  ObservableMap<int, Category> _categories;
  ObservableMap<int, Category> get categories {
    $observe('categories');

    return _categories;
  }

  set categories(ObservableMap<int, Category> categories) {
    if (categories != null && categories == _categories) return;
    _categories = categories;
    $notify('categories');
  }

  ObservableMap<int, User> _users;
  ObservableMap<int, User> get users {
    $observe('users');

    return _users;
  }

  set users(ObservableMap<int, User> users) {
    if (users != null && users == _users) return;
    _users = users;
    $notify('users');
  }

  ObservableMap<int, Room> _rooms;
  ObservableMap<int, Room> get rooms {
    $observe('rooms');

    return _rooms;
  }

  set rooms(ObservableMap<int, Room> rooms) {
    if (rooms != null && rooms == _rooms) return;
    _rooms = rooms;
    $notify('rooms');
  }

  _$AppState.$() : super.$();
  factory _$AppState({
    User activeUser,
    UnreadInfo unreadInfo,
    ObservableMap<int, Topic> topics,
    ObservableMap<int, Category> categories,
    ObservableMap<int, User> users,
    ObservableMap<int, Room> rooms,
  }) {
    return new _$AppState.$()
      .._activeUser = activeUser
      .._unreadInfo = unreadInfo
      .._topics = topics
      .._categories = categories
      .._users = users
      .._rooms = rooms;
  }
}
