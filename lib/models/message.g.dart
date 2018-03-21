// GENERATED CODE - DO NOT MODIFY BY HAND

part of message;

// **************************************************************************
// Generator: WillsGenerator
// **************************************************************************

class _$Message extends Message {
  int _id;
  int get id {
    $observe('id');
    _id = _id ?? 0;
    return _id;
  }

  set id(int id) {
    if (id != null && id == _id) return;
    _id = id;
    $notify('id');
  }

  User _user;
  User get user {
    $observe('user');

    return _user;
  }

  set user(User user) {
    if (user != null && user == _user) return;
    _user = user;
    $notify('user');
  }

  DateTime _timestamp;
  DateTime get timestamp {
    $observe('timestamp');

    return _timestamp;
  }

  set timestamp(DateTime timestamp) {
    if (timestamp != null && timestamp == _timestamp) return;
    _timestamp = timestamp;
    $notify('timestamp');
  }

  String _content;
  String get content {
    $observe('content');
    _content = _content ?? '';
    return _content;
  }

  set content(String content) {
    if (content != null && content == _content) return;
    _content = content;
    $notify('content');
  }

  MessageType _type;
  MessageType get type {
    $observe('type');

    return _type;
  }

  set type(MessageType type) {
    if (type != null && type == _type) return;
    _type = type;
    $notify('type');
  }

  _$Message.$() : super.$();
  factory _$Message({
    int id: 0,
    User user,
    DateTime timestamp,
    String content: '',
    MessageType type,
  }) {
    return new _$Message.$()
      .._id = id
      .._user = user
      .._timestamp = timestamp
      .._content = content
      .._type = type;
  }
}
