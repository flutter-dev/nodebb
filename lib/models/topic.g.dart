// GENERATED CODE - DO NOT MODIFY BY HAND

part of topic;

// **************************************************************************
// Generator: WillsGenerator
// **************************************************************************

class _$Topic extends Topic {
  int _cid;
  int get cid {
    $observe('cid');
    return _cid;
  }

  set cid(int cid) {
    if (cid == _cid) return;
    _cid = cid;
    $notify('cid');
  }

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

  int _mainPid;
  int get mainPid {
    $observe('mainPid');
    return _mainPid;
  }

  set mainPid(int mainPid) {
    if (mainPid == _mainPid) return;
    _mainPid = mainPid;
    $notify('mainPid');
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

  bool _isOwner;
  bool get isOwner {
    $observe('isOwner');
    return _isOwner;
  }

  set isOwner(bool isOwner) {
    if (isOwner == _isOwner) return;
    _isOwner = isOwner;
    $notify('isOwner');
  }

  String _title;
  String get title {
    $observe('title');
    return _title;
  }

  set title(String title) {
    if (title == _title) return;
    _title = title;
    $notify('title');
  }

  DateTime _lastPostTime;
  DateTime get lastPostTime {
    $observe('lastPostTime');
    return _lastPostTime;
  }

  set lastPostTime(DateTime lastPostTime) {
    if (lastPostTime == _lastPostTime) return;
    _lastPostTime = lastPostTime;
    $notify('lastPostTime');
  }

  int _postCount;
  int get postCount {
    $observe('postCount');
    return _postCount;
  }

  set postCount(int postCount) {
    if (postCount == _postCount) return;
    _postCount = postCount;
    $notify('postCount');
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

  int _viewCount;
  int get viewCount {
    $observe('viewCount');
    return _viewCount;
  }

  set viewCount(int viewCount) {
    if (viewCount == _viewCount) return;
    _viewCount = viewCount;
    $notify('viewCount');
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

  _$Topic.$() : super.$();
  factory _$Topic({
    int cid,
    int tid,
    int mainPid,
    User user,
    bool isOwner,
    String title,
    DateTime lastPostTime,
    int postCount,
    DateTime timestamp,
    int viewCount,
    int upVotes,
    int downVotes,
  }) {
    return new _$Topic.$()
      .._cid = cid ?? 0
      .._tid = tid ?? 0
      .._mainPid = mainPid ?? 0
      .._user = user
      .._isOwner = isOwner ?? false
      .._title = title ?? ''
      .._lastPostTime = lastPostTime
      .._postCount = postCount ?? 0
      .._timestamp = timestamp
      .._viewCount = viewCount ?? 0
      .._upVotes = upVotes ?? 0
      .._downVotes = downVotes ?? 0;
  }
}
