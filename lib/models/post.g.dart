// GENERATED CODE - DO NOT MODIFY BY HAND

part of post;

// **************************************************************************
// Generator: WillsGenerator
// **************************************************************************

class _$Post extends Post {
  int _tid;
  int get tid {
    $observe('tid');
    _tid = _tid ?? 0;
    return _tid;
  }

  set tid(int tid) {
    if (tid != null && tid == _tid) return;
    _tid = tid;
    $notify('tid');
  }

  int _pid;
  int get pid {
    $observe('pid');
    _pid = _pid ?? 0;
    return _pid;
  }

  set pid(int pid) {
    if (pid != null && pid == _pid) return;
    _pid = pid;
    $notify('pid');
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

  bool _downVoted;
  bool get downVoted {
    $observe('downVoted');
    _downVoted = _downVoted ?? false;
    return _downVoted;
  }

  set downVoted(bool downVoted) {
    if (downVoted != null && downVoted == _downVoted) return;
    _downVoted = downVoted;
    $notify('downVoted');
  }

  bool _upVoted;
  bool get upVoted {
    $observe('upVoted');
    _upVoted = _upVoted ?? false;
    return _upVoted;
  }

  set upVoted(bool upVoted) {
    if (upVoted != null && upVoted == _upVoted) return;
    _upVoted = upVoted;
    $notify('upVoted');
  }

  int _upVotes;
  int get upVotes {
    $observe('upVotes');
    _upVotes = _upVotes ?? 0;
    return _upVotes;
  }

  set upVotes(int upVotes) {
    if (upVotes != null && upVotes == _upVotes) return;
    _upVotes = upVotes;
    $notify('upVotes');
  }

  int _downVotes;
  int get downVotes {
    $observe('downVotes');
    _downVotes = _downVotes ?? 0;
    return _downVotes;
  }

  set downVotes(int downVotes) {
    if (downVotes != null && downVotes == _downVotes) return;
    _downVotes = downVotes;
    $notify('downVotes');
  }

  int _votes;
  int get votes {
    $observe('votes');
    _votes = _votes ?? 0;
    return _votes;
  }

  set votes(int votes) {
    if (votes != null && votes == _votes) return;
    _votes = votes;
    $notify('votes');
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

  _$Post.$() : super.$();
  factory _$Post({
    int tid: 0,
    int pid: 0,
    User user,
    bool downVoted: false,
    bool upVoted: false,
    int upVotes: 0,
    int downVotes: 0,
    int votes: 0,
    DateTime timestamp,
    String content: '',
  }) {
    return new _$Post.$()
      .._tid = tid
      .._pid = pid
      .._user = user
      .._downVoted = downVoted
      .._upVoted = upVoted
      .._upVotes = upVotes
      .._downVotes = downVotes
      .._votes = votes
      .._timestamp = timestamp
      .._content = content;
  }
}
