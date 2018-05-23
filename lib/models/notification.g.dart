// GENERATED CODE - DO NOT MODIFY BY HAND

part of notification;

// **************************************************************************
// Generator: WillsGenerator
// **************************************************************************

class _$NodeBBNotification extends NodeBBNotification {
  bool _newReply;
  bool get newReply {
    $observe('newReply');
    return _newReply;
  }

  set newReply(bool newReply) {
    if (newReply == _newReply) return;
    _newReply = newReply;
    $notify('newReply');
  }

  bool _newChat;
  bool get newChat {
    $observe('newChat');
    return _newChat;
  }

  set newChat(bool newChat) {
    if (newChat == _newChat) return;
    _newChat = newChat;
    $notify('newChat');
  }

  bool _newFollow;
  bool get newFollow {
    $observe('newFollow');
    return _newFollow;
  }

  set newFollow(bool newFollow) {
    if (newFollow == _newFollow) return;
    _newFollow = newFollow;
    $notify('newFollow');
  }

  bool _groupInvite;
  bool get groupInvite {
    $observe('groupInvite');
    return _groupInvite;
  }

  set groupInvite(bool groupInvite) {
    if (groupInvite == _groupInvite) return;
    _groupInvite = groupInvite;
    $notify('groupInvite');
  }

  bool _newTopic;
  bool get newTopic {
    $observe('newTopic');
    return _newTopic;
  }

  set newTopic(bool newTopic) {
    if (newTopic == _newTopic) return;
    _newTopic = newTopic;
    $notify('newTopic');
  }

  _$NodeBBNotification.$() : super.$();
  factory _$NodeBBNotification({
    bool newReply,
    bool newChat,
    bool newFollow,
    bool groupInvite,
    bool newTopic,
  }) {
    return new _$NodeBBNotification.$()
      .._newReply = newReply ?? false
      .._newChat = newChat ?? false
      .._newFollow = newFollow ?? false
      .._groupInvite = groupInvite ?? false
      .._newTopic = newTopic ?? false;
  }
}
