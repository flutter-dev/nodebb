// GENERATED CODE - DO NOT MODIFY BY HAND

part of app_state;

// **************************************************************************
// Generator: WillsGenerator
// **************************************************************************

class _$AppState extends AppState {
  User _activeUser;
  User get activeUser {
    $observe('activeUser');

    $checkType(_activeUser);
    return _activeUser;
  }

  set activeUser(User activeUser) {
    if (activeUser != null && activeUser == _activeUser) return;
    _activeUser = activeUser;
    $notify('activeUser');
  }

  ObservableMap<int, Topic> _topics;
  ObservableMap<int, Topic> get topics {
    $observe('topics');

    $checkType(_topics);
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

    $checkType(_categories);
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

    $checkType(_users);
    return _users;
  }

  set users(ObservableMap<int, User> users) {
    if (users != null && users == _users) return;
    _users = users;
    $notify('users');
  }

  _$AppState.$() : super.$();
  factory _$AppState({
    User activeUser,
    ObservableMap<int, Topic> topics,
    ObservableMap<int, Category> categories,
    ObservableMap<int, User> users,
  }) {
    return new _$AppState.$()
      .._activeUser = activeUser
      .._topics = topics
      .._categories = categories
      .._users = users;
  }
}
