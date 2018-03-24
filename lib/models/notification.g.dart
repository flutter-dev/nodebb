// GENERATED CODE - DO NOT MODIFY BY HAND

part of notification;

// **************************************************************************
// Generator: WillsGenerator
// **************************************************************************

class _$NodeBBNotification extends NodeBBNotification {
  bool _newReply;
  bool get newReply {
    $observe('newReply');
    _newReply = _newReply ?? false;
    return _newReply;
  }

  set newReply(bool newReply) {
    if (newReply != null && newReply == _newReply) return;
    _newReply = newReply;
    $notify('newReply');
  }

  bool _newChat;
  bool get newChat {
    $observe('newChat');
    _newChat = _newChat ?? false;
    return _newChat;
  }

  set newChat(bool newChat) {
    if (newChat != null && newChat == _newChat) return;
    _newChat = newChat;
    $notify('newChat');
  }

  bool _newFollow;
  bool get newFollow {
    $observe('newFollow');
    _newFollow = _newFollow ?? false;
    return _newFollow;
  }

  set newFollow(bool newFollow) {
    if (newFollow != null && newFollow == _newFollow) return;
    _newFollow = newFollow;
    $notify('newFollow');
  }

  bool _groupInvite;
  bool get groupInvite {
    $observe('groupInvite');
    _groupInvite = _groupInvite ?? false;
    return _groupInvite;
  }

  set groupInvite(bool groupInvite) {
    if (groupInvite != null && groupInvite == _groupInvite) return;
    _groupInvite = groupInvite;
    $notify('groupInvite');
  }

  bool _newTopic;
  bool get newTopic {
    $observe('newTopic');
    _newTopic = _newTopic ?? false;
    return _newTopic;
  }

  set newTopic(bool newTopic) {
    if (newTopic != null && newTopic == _newTopic) return;
    _newTopic = newTopic;
    $notify('newTopic');
  }

  _$NodeBBNotification.$() : super.$();
  factory _$NodeBBNotification({
    bool newReply: false,
    bool newChat: false,
    bool newFollow: false,
    bool groupInvite: false,
    bool newTopic: false,
  }) {
    return new _$NodeBBNotification.$()
      .._newReply = newReply
      .._newChat = newChat
      .._newFollow = newFollow
      .._groupInvite = groupInvite
      .._newTopic = newTopic;
  }
}
