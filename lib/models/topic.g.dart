// GENERATED CODE - DO NOT MODIFY BY HAND

part of topic;

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

class _$Topic extends Topic {
  @override
  final int cid;
  @override
  final int tid;
  @override
  final int uid;
  @override
  final bool isOwner;
  @override
  final String title;
  @override
  final DateTime lastPostTime;
  @override
  final int postCount;
  @override
  final DateTime timestamp;
  @override
  final int viewCount;
  @override
  final int upVotes;
  @override
  final int downVotes;
  @override
  final BuiltList<int> posts;

  factory _$Topic([void updates(TopicBuilder b)]) =>
      (new TopicBuilder()..update(updates)).build();

  _$Topic._(
      {this.cid,
      this.tid,
      this.uid,
      this.isOwner,
      this.title,
      this.lastPostTime,
      this.postCount,
      this.timestamp,
      this.viewCount,
      this.upVotes,
      this.downVotes,
      this.posts})
      : super._() {
    if (cid == null) throw new BuiltValueNullFieldError('Topic', 'cid');
    if (tid == null) throw new BuiltValueNullFieldError('Topic', 'tid');
    if (uid == null) throw new BuiltValueNullFieldError('Topic', 'uid');
    if (isOwner == null) throw new BuiltValueNullFieldError('Topic', 'isOwner');
    if (title == null) throw new BuiltValueNullFieldError('Topic', 'title');
    if (lastPostTime == null)
      throw new BuiltValueNullFieldError('Topic', 'lastPostTime');
    if (postCount == null)
      throw new BuiltValueNullFieldError('Topic', 'postCount');
    if (timestamp == null)
      throw new BuiltValueNullFieldError('Topic', 'timestamp');
    if (viewCount == null)
      throw new BuiltValueNullFieldError('Topic', 'viewCount');
    if (upVotes == null) throw new BuiltValueNullFieldError('Topic', 'upVotes');
    if (downVotes == null)
      throw new BuiltValueNullFieldError('Topic', 'downVotes');
  }

  @override
  Topic rebuild(void updates(TopicBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TopicBuilder toBuilder() => new TopicBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Topic) return false;
    return cid == other.cid &&
        tid == other.tid &&
        uid == other.uid &&
        isOwner == other.isOwner &&
        title == other.title &&
        lastPostTime == other.lastPostTime &&
        postCount == other.postCount &&
        timestamp == other.timestamp &&
        viewCount == other.viewCount &&
        upVotes == other.upVotes &&
        downVotes == other.downVotes &&
        posts == other.posts;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc($jc(0, cid.hashCode),
                                                tid.hashCode),
                                            uid.hashCode),
                                        isOwner.hashCode),
                                    title.hashCode),
                                lastPostTime.hashCode),
                            postCount.hashCode),
                        timestamp.hashCode),
                    viewCount.hashCode),
                upVotes.hashCode),
            downVotes.hashCode),
        posts.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Topic')
          ..add('cid', cid)
          ..add('tid', tid)
          ..add('uid', uid)
          ..add('isOwner', isOwner)
          ..add('title', title)
          ..add('lastPostTime', lastPostTime)
          ..add('postCount', postCount)
          ..add('timestamp', timestamp)
          ..add('viewCount', viewCount)
          ..add('upVotes', upVotes)
          ..add('downVotes', downVotes)
          ..add('posts', posts))
        .toString();
  }
}

class TopicBuilder implements Builder<Topic, TopicBuilder> {
  _$Topic _$v;

  int _cid;
  int get cid => _$this._cid;
  set cid(int cid) => _$this._cid = cid;

  int _tid;
  int get tid => _$this._tid;
  set tid(int tid) => _$this._tid = tid;

  int _uid;
  int get uid => _$this._uid;
  set uid(int uid) => _$this._uid = uid;

  bool _isOwner;
  bool get isOwner => _$this._isOwner;
  set isOwner(bool isOwner) => _$this._isOwner = isOwner;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  DateTime _lastPostTime;
  DateTime get lastPostTime => _$this._lastPostTime;
  set lastPostTime(DateTime lastPostTime) =>
      _$this._lastPostTime = lastPostTime;

  int _postCount;
  int get postCount => _$this._postCount;
  set postCount(int postCount) => _$this._postCount = postCount;

  DateTime _timestamp;
  DateTime get timestamp => _$this._timestamp;
  set timestamp(DateTime timestamp) => _$this._timestamp = timestamp;

  int _viewCount;
  int get viewCount => _$this._viewCount;
  set viewCount(int viewCount) => _$this._viewCount = viewCount;

  int _upVotes;
  int get upVotes => _$this._upVotes;
  set upVotes(int upVotes) => _$this._upVotes = upVotes;

  int _downVotes;
  int get downVotes => _$this._downVotes;
  set downVotes(int downVotes) => _$this._downVotes = downVotes;

  ListBuilder<int> _posts;
  ListBuilder<int> get posts => _$this._posts ??= new ListBuilder<int>();
  set posts(ListBuilder<int> posts) => _$this._posts = posts;

  TopicBuilder();

  TopicBuilder get _$this {
    if (_$v != null) {
      _cid = _$v.cid;
      _tid = _$v.tid;
      _uid = _$v.uid;
      _isOwner = _$v.isOwner;
      _title = _$v.title;
      _lastPostTime = _$v.lastPostTime;
      _postCount = _$v.postCount;
      _timestamp = _$v.timestamp;
      _viewCount = _$v.viewCount;
      _upVotes = _$v.upVotes;
      _downVotes = _$v.downVotes;
      _posts = _$v.posts?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Topic other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Topic;
  }

  @override
  void update(void updates(TopicBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Topic build() {
    _$Topic _$result;
    try {
      _$result = _$v ??
          new _$Topic._(
              cid: cid,
              tid: tid,
              uid: uid,
              isOwner: isOwner,
              title: title,
              lastPostTime: lastPostTime,
              postCount: postCount,
              timestamp: timestamp,
              viewCount: viewCount,
              upVotes: upVotes,
              downVotes: downVotes,
              posts: _posts?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'posts';
        _posts?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Topic', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
