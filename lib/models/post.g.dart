// GENERATED CODE - DO NOT MODIFY BY HAND

part of post;

// **************************************************************************
// Generator: WillsGenerator
// **************************************************************************

class _$Post extends Post {
  int _tid;
  int get tid {
    $observe('tid');
    return _tid;
  }

  set tid(int tid) {
    if (tid == _tid) return;
    _tid = tid;
    $notify('tid');
  }

  int _pid;
  int get pid {
    $observe('pid');
    return _pid;
  }

  set pid(int pid) {
    if (pid == _pid) return;
    _pid = pid;
    $notify('pid');
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

  bool _downVoted;
  bool get downVoted {
    $observe('downVoted');
    return _downVoted;
  }

  set downVoted(bool downVoted) {
    if (downVoted == _downVoted) return;
    _downVoted = downVoted;
    $notify('downVoted');
  }

  bool _upVoted;
  bool get upVoted {
    $observe('upVoted');
    return _upVoted;
  }

  set upVoted(bool upVoted) {
    if (upVoted == _upVoted) return;
    _upVoted = upVoted;
    $notify('upVoted');
  }

  int _upVotes;
  int get upVotes {
    $observe('upVotes');
    return _upVotes;
  }

  set upVotes(int upVotes) {
    if (upVotes == _upVotes) return;
    _upVotes = upVotes;
    $notify('upVotes');
  }

  int _downVotes;
  int get downVotes {
    $observe('downVotes');
    return _downVotes;
  }

  set downVotes(int downVotes) {
    if (downVotes == _downVotes) return;
    _downVotes = downVotes;
    $notify('downVotes');
  }

  int _votes;
  int get votes {
    $observe('votes');
    return _votes;
  }

  set votes(int votes) {
    if (votes == _votes) return;
    _votes = votes;
    $notify('votes');
  }

  bool _isMainPost;
  bool get isMainPost {
    $observe('isMainPost');
    return _isMainPost;
  }

  set isMainPost(bool isMainPost) {
    if (isMainPost == _isMainPost) return;
    _isMainPost = isMainPost;
    $notify('isMainPost');
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

  _$Post.$() : super.$();
  factory _$Post({
    int tid,
    int pid,
    User user,
    bool downVoted,
    bool upVoted,
    int upVotes,
    int downVotes,
    int votes,
    bool isMainPost,
    DateTime timestamp,
    String content,
  }) {
    return new _$Post.$()
      .._tid = tid ?? 0
      .._pid = pid ?? 0
      .._user = user
      .._downVoted = downVoted ?? false
      .._upVoted = upVoted ?? false
      .._upVotes = upVotes ?? 0
      .._downVotes = downVotes ?? 0
      .._votes = votes ?? 0
      .._isMainPost = isMainPost ?? false
      .._timestamp = timestamp
      .._content = content ?? '';
  }
}
