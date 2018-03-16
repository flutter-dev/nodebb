// GENERATED CODE - DO NOT MODIFY BY HAND

part of room;

// **************************************************************************
// Generator: WillsGenerator
// **************************************************************************

class _$Room extends Room {
  int _owner;
  int get owner {
    $observe('owner');
    _owner = _owner ?? 0;
    return _owner;
  }

  set owner(int owner) {
    if (owner != null && owner == _owner) return;
    _owner = owner;
    $notify('owner');
  }

  int _roomId;
  int get roomId {
    $observe('roomId');
    _roomId = _roomId ?? 0;
    return _roomId;
  }

  set roomId(int roomId) {
    if (roomId != null && roomId == _roomId) return;
    _roomId = roomId;
    $notify('roomId');
  }

  String _roomName;
  String get roomName {
    $observe('roomName');
    _roomName = _roomName ?? '';
    return _roomName;
  }

  set roomName(String roomName) {
    if (roomName != null && roomName == _roomName) return;
    _roomName = roomName;
    $notify('roomName');
  }

  ObservableList<User> _users;
  ObservableList<User> get users {
    $observe('users');

    return _users;
  }

  set users(ObservableList<User> users) {
    if (users != null && users == _users) return;
    _users = users;
    $notify('users');
  }

  bool _groupChat;
  bool get groupChat {
    $observe('groupChat');
    _groupChat = _groupChat ?? false;
    return _groupChat;
  }

  set groupChat(bool groupChat) {
    if (groupChat != null && groupChat == _groupChat) return;
    _groupChat = groupChat;
    $notify('groupChat');
  }

  bool _unread;
  bool get unread {
    $observe('unread');
    _unread = _unread ?? false;
    return _unread;
  }

  set unread(bool unread) {
    if (unread != null && unread == _unread) return;
    _unread = unread;
    $notify('unread');
  }

  String _ownerName;
  String get ownerName {
    $observe('ownerName');
    _ownerName = _ownerName ?? '';
    return _ownerName;
  }

  set ownerName(String ownerName) {
    if (ownerName != null && ownerName == _ownerName) return;
    _ownerName = ownerName;
    $notify('ownerName');
  }

  Teaser _teaser;
  Teaser get teaser {
    $observe('teaser');

    return _teaser;
  }

  set teaser(Teaser teaser) {
    if (teaser != null && teaser == _teaser) return;
    _teaser = teaser;
    $notify('teaser');
  }

  int _maxChatMessageLength;
  int get maxChatMessageLength {
    $observe('maxChatMessageLength');
    _maxChatMessageLength = _maxChatMessageLength ?? 0;
    return _maxChatMessageLength;
  }

  set maxChatMessageLength(int maxChatMessageLength) {
    if (maxChatMessageLength != null &&
        maxChatMessageLength == _maxChatMessageLength) return;
    _maxChatMessageLength = maxChatMessageLength;
    $notify('maxChatMessageLength');
  }

  ObservableList<Message> _messages;
  ObservableList<Message> get messages {
    $observe('messages');

    return _messages;
  }

  set messages(ObservableList<Message> messages) {
    if (messages != null && messages == _messages) return;
    _messages = messages;
    $notify('messages');
  }

  _$Room.$() : super.$();
  factory _$Room({
    int owner: 0,
    int roomId: 0,
    String roomName: '',
    ObservableList<User> users,
    bool groupChat: false,
    bool unread: false,
    String ownerName: '',
    Teaser teaser,
    int maxChatMessageLength: 0,
    ObservableList<Message> messages,
  }) {
    return new _$Room.$()
      .._owner = owner
      .._roomId = roomId
      .._roomName = roomName
      .._users = users
      .._groupChat = groupChat
      .._unread = unread
      .._ownerName = ownerName
      .._teaser = teaser
      .._maxChatMessageLength = maxChatMessageLength
      .._messages = messages;
  }
}
