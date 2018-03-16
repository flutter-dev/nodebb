// GENERATED CODE - DO NOT MODIFY BY HAND

part of message;

// **************************************************************************
// Generator: WillsGenerator
// **************************************************************************

class _$Message extends Message {
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
    User user,
    DateTime timestamp,
    String content: '',
    MessageType type,
  }) {
    return new _$Message.$()
      .._user = user
      .._timestamp = timestamp
      .._content = content
      .._type = type;
  }
}
