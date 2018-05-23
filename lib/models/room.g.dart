// GENERATED CODE - DO NOT MODIFY BY HAND

part of room;

// **************************************************************************
// Generator: WillsGenerator
// **************************************************************************

class _$Room extends Room {
  int _owner;
  int get owner {
    $observe('owner');
    return _owner;
  }

  set owner(int owner) {
    if (owner == _owner) return;
    _owner = owner;
    $notify('owner');
  }

  int _roomId;
  int get roomId {
    $observe('roomId');
    return _roomId;
  }

  set roomId(int roomId) {
    if (roomId == _roomId) return;
    _roomId = roomId;
    $notify('roomId');
  }

  String _roomName;
  String get roomName {
    $observe('roomName');
    return _roomName;
  }

  set roomName(String roomName) {
    if (roomName == _roomName) return;
    _roomName = roomName;
    $notify('roomName');
  }

  ObservableList<User> _users;
  ObservableList<User> get users {
    $observe('users');
    return _users;
  }

  set users(ObservableList<User> users) {
    if (users == _users) return;
    _users = users;
    $notify('users');
  }

  bool _groupChat;
  bool get groupChat {
    $observe('groupChat');
    return _groupChat;
  }

  set groupChat(bool groupChat) {
    if (groupChat == _groupChat) return;
    _groupChat = groupChat;
    $notify('groupChat');
  }

  bool _unread;
  bool get unread {
    $observe('unread');
    return _unread;
  }

  set unread(bool unread) {
    if (unread == _unread) return;
    _unread = unread;
    $notify('unread');
  }

  String _ownerName;
  String get ownerName {
    $observe('ownerName');
    return _ownerName;
  }

  set ownerName(String ownerName) {
    if (ownerName == _ownerName) return;
    _ownerName = ownerName;
    $notify('ownerName');
  }

  Teaser _teaser;
  Teaser get teaser {
    $observe('teaser');
    return _teaser;
  }

  set teaser(Teaser teaser) {
    if (teaser == _teaser) return;
    _teaser = teaser;
    $notify('teaser');
  }

  int _maxChatMessageLength;
  int get maxChatMessageLength {
    $observe('maxChatMessageLength');
    return _maxChatMessageLength;
  }

  set maxChatMessageLength(int maxChatMessageLength) {
    if (maxChatMessageLength == _maxChatMessageLength) return;
    _maxChatMessageLength = maxChatMessageLength;
    $notify('maxChatMessageLength');
  }

  ObservableList<Message> _messages;
  ObservableList<Message> get messages {
    $observe('messages');
    return _messages;
  }

  set messages(ObservableList<Message> messages) {
    if (messages == _messages) return;
    _messages = messages;
    $notify('messages');
  }

  _$Room.$() : super.$();
  factory _$Room({
    int owner,
    int roomId,
    String roomName,
    ObservableList<User> users,
    bool groupChat,
    bool unread,
    String ownerName,
    Teaser teaser,
    int maxChatMessageLength,
    ObservableList<Message> messages,
  }) {
    return new _$Room.$()
      .._owner = owner ?? 0
      .._roomId = roomId ?? 0
      .._roomName = roomName ?? ''
      .._users = users
      .._groupChat = groupChat ?? false
      .._unread = unread ?? false
      .._ownerName = ownerName ?? ''
      .._teaser = teaser
      .._maxChatMessageLength = maxChatMessageLength ?? 0
      .._messages = messages;
  }
}
