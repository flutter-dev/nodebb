// GENERATED CODE - DO NOT MODIFY BY HAND

part of teaser;

// **************************************************************************
// Generator: WillsGenerator
// **************************************************************************

class _$Teaser extends Teaser {
  User _fromUser;
  User get fromUser {
    $observe('fromUser');
    return _fromUser;
  }

  set fromUser(User fromUser) {
    if (fromUser == _fromUser) return;
    _fromUser = fromUser;
    $notify('fromUser');
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

  int _timestamp;
  int get timestamp {
    $observe('timestamp');
    return _timestamp;
  }

  set timestamp(int timestamp) {
    if (timestamp == _timestamp) return;
    _timestamp = timestamp;
    $notify('timestamp');
  }

  _$Teaser.$() : super.$();
  factory _$Teaser({
    User fromUser,
    String content,
    int timestamp,
  }) {
    return new _$Teaser.$()
      .._fromUser = fromUser
      .._content = content ?? ''
      .._timestamp = timestamp ?? 0;
  }
}
