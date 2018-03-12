// GENERATED CODE - DO NOT MODIFY BY HAND

part of topic;

// **************************************************************************
// Generator: WillsGenerator
// **************************************************************************

class _$Topic extends Topic {
  int _cid;
  int get cid {
    $observe('cid');
    _cid = _cid ?? 0;
    $checkType(_cid);
    return _cid;
  }

  set cid(int cid) {
    if (cid != null && cid == _cid) return;
    _cid = cid;
    $notify('cid');
  }

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

  bool _isOwner;
  bool get isOwner {
    $observe('isOwner');
    _isOwner = _isOwner ?? false;
    $checkType(_isOwner);
    return _isOwner;
  }

  set isOwner(bool isOwner) {
    if (isOwner != null && isOwner == _isOwner) return;
    _isOwner = isOwner;
    $notify('isOwner');
  }

  String _title;
  String get title {
    $observe('title');
    _title = _title ?? '';
    $checkType(_title);
    return _title;
  }

  set title(String title) {
    if (title != null && title == _title) return;
    _title = title;
    $notify('title');
  }

  DateTime _lastPostTime;
  DateTime get lastPostTime {
    $observe('lastPostTime');

    $checkType(_lastPostTime);
    return _lastPostTime;
  }

  set lastPostTime(DateTime lastPostTime) {
    if (lastPostTime != null && lastPostTime == _lastPostTime) return;
    _lastPostTime = lastPostTime;
    $notify('lastPostTime');
  }

  int _postCount;
  int get postCount {
    $observe('postCount');
    _postCount = _postCount ?? 0;
    $checkType(_postCount);
    return _postCount;
  }

  set postCount(int postCount) {
    if (postCount != null && postCount == _postCount) return;
    _postCount = postCount;
    $notify('postCount');
  }

  DateTime _timestamp;
  DateTime get timestamp {
    $observe('timestamp');

    $checkType(_timestamp);
    return _timestamp;
  }

  set timestamp(DateTime timestamp) {
    if (timestamp != null && timestamp == _timestamp) return;
    _timestamp = timestamp;
    $notify('timestamp');
  }

  int _viewCount;
  int get viewCount {
    $observe('viewCount');
    _viewCount = _viewCount ?? 0;
    $checkType(_viewCount);
    return _viewCount;
  }

  set viewCount(int viewCount) {
    if (viewCount != null && viewCount == _viewCount) return;
    _viewCount = viewCount;
    $notify('viewCount');
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

  ObservableList<int> _posts;
  ObservableList<int> get posts {
    $observe('posts');

    $checkType(_posts);
    return _posts;
  }

  set posts(ObservableList<int> posts) {
    if (posts != null && posts == _posts) return;
    _posts = posts;
    $notify('posts');
  }

  _$Topic.$() : super.$();
  factory _$Topic({
    int cid: 0,
    int tid: 0,
    int uid: 0,
    bool isOwner: false,
    String title: '',
    DateTime lastPostTime,
    int postCount: 0,
    DateTime timestamp,
    int viewCount: 0,
    int upVotes: 0,
    int downVotes: 0,
    ObservableList<int> posts,
  }) {
    return new _$Topic.$()
      .._cid = cid
      .._tid = tid
      .._uid = uid
      .._isOwner = isOwner
      .._title = title
      .._lastPostTime = lastPostTime
      .._postCount = postCount
      .._timestamp = timestamp
      .._viewCount = viewCount
      .._upVotes = upVotes
      .._downVotes = downVotes
      .._posts = posts;
  }
}
