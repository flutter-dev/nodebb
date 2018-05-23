// GENERATED CODE - DO NOT MODIFY BY HAND

part of message;

// **************************************************************************
// Generator: WillsGenerator
// **************************************************************************

class _$Message extends Message {
  int _id;
  int get id {
    $observe('id');
    return _id;
  }

  set id(int id) {
    if (id == _id) return;
    _id = id;
    $notify('id');
  }

  User _user;
  User get user {
    $observe('user');
    return _user;
  }

  set user(User user) {
    if (user == _user) return;
    _user = user;
    $notify('user');
  }

  DateTime _timestamp;
  DateTime get timestamp {
    $observe('timestamp');
    return _timestamp;
  }

  set timestamp(DateTime timestamp) {
    if (timestamp == _timestamp) return;
    _timestamp = timestamp;
    $notify('timestamp');
  }

  String _content;
  String get content {
    $observe('content');
    return _content;
  }

  set content(String content) {
    if (content == _content) return;
    _content = content;
    $notify('content');
  }

  MessageType _type;
  MessageType get type {
    $observe('type');
    return _type;
  }

  set type(MessageType type) {
    if (type == _type) return;
    _type = type;
    $notify('type');
  }

  _$Message.$() : super.$();
  factory _$Message({
    int id,
    User user,
    DateTime timestamp,
    String content,
    MessageType type,
  }) {
    return new _$Message.$()
      .._id = id ?? 0
      .._user = user
      .._timestamp = timestamp
      .._content = content ?? ''
      .._type = type;
  }
}
