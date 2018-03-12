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
    $checkType(_tid);
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
    $checkType(_pid);
    return _pid;
  }

  set pid(int pid) {
    if (pid != null && pid == _pid) return;
    _pid = pid;
    $notify('pid');
  }

  int _uid;
  int get uid {
    $observe('uid');
    _uid = _uid ?? 0;
    $checkType(_uid);
    return _uid;
  }

  set uid(int uid) {
    if (uid != null && uid == _uid) return;
    _uid = uid;
    $notify('uid');
  }

  bool _downVoted;
  bool get downVoted {
    $observe('downVoted');
    _downVoted = _downVoted ?? false;
    $checkType(_downVoted);
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
    $checkType(_upVoted);
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
    $checkType(_upVotes);
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
    $checkType(_downVotes);
    return _downVotes;
  }

  set downVotes(int downVotes) {
    if (downVotes != null && downVotes == _downVotes) return;
    _downVotes = downVotes;
    $notify('downVotes');
  }

  String _content;
  String get content {
    $observe('content');
    _content = _content ?? '';
    $checkType(_content);
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
    int uid: 0,
    bool downVoted: false,
    bool upVoted: false,
    int upVotes: 0,
    int downVotes: 0,
    String content: '',
  }) {
    return new _$Post.$()
      .._tid = tid
      .._pid = pid
      .._uid = uid
      .._downVoted = downVoted
      .._upVoted = upVoted
      .._upVotes = upVotes
      .._downVotes = downVotes
      .._content = content;
  }
}
