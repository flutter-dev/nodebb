// GENERATED CODE - DO NOT MODIFY BY HAND

part of post;

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

class _$Post extends Post {
  @override
  final int tid;
  @override
  final int pid;
  @override
  final int uid;
  @override
  final bool downVoted;
  @override
  final bool upVoted;
  @override
  final int upVotes;
  @override
  final int downVotes;
  @override
  final String content;

  factory _$Post([void updates(PostBuilder b)]) =>
      (new PostBuilder()..update(updates)).build();

  _$Post._(
      {this.tid,
      this.pid,
      this.uid,
      this.downVoted,
      this.upVoted,
      this.upVotes,
      this.downVotes,
      this.content})
      : super._() {
    if (tid == null) throw new BuiltValueNullFieldError('Post', 'tid');
    if (pid == null) throw new BuiltValueNullFieldError('Post', 'pid');
    if (uid == null) throw new BuiltValueNullFieldError('Post', 'uid');
    if (downVoted == null)
      throw new BuiltValueNullFieldError('Post', 'downVoted');
    if (upVoted == null) throw new BuiltValueNullFieldError('Post', 'upVoted');
    if (upVotes == null) throw new BuiltValueNullFieldError('Post', 'upVotes');
    if (downVotes == null)
      throw new BuiltValueNullFieldError('Post', 'downVotes');
    if (content == null) throw new BuiltValueNullFieldError('Post', 'content');
  }

  @override
  Post rebuild(void updates(PostBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  PostBuilder toBuilder() => new PostBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Post) return false;
    return tid == other.tid &&
        pid == other.pid &&
        uid == other.uid &&
        downVoted == other.downVoted &&
        upVoted == other.upVoted &&
        upVotes == other.upVotes &&
        downVotes == other.downVotes &&
        content == other.content;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, tid.hashCode), pid.hashCode),
                            uid.hashCode),
                        downVoted.hashCode),
                    upVoted.hashCode),
                upVotes.hashCode),
            downVotes.hashCode),
        content.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Post')
          ..add('tid', tid)
          ..add('pid', pid)
          ..add('uid', uid)
          ..add('downVoted', downVoted)
          ..add('upVoted', upVoted)
          ..add('upVotes', upVotes)
          ..add('downVotes', downVotes)
          ..add('content', content))
        .toString();
  }
}

class PostBuilder implements Builder<Post, PostBuilder> {
  _$Post _$v;

  int _tid;
  int get tid => _$this._tid;
  set tid(int tid) => _$this._tid = tid;

  int _pid;
  int get pid => _$this._pid;
  set pid(int pid) => _$this._pid = pid;

  int _uid;
  int get uid => _$this._uid;
  set uid(int uid) => _$this._uid = uid;

  bool _downVoted;
  bool get downVoted => _$this._downVoted;
  set downVoted(bool downVoted) => _$this._downVoted = downVoted;

  bool _upVoted;
  bool get upVoted => _$this._upVoted;
  set upVoted(bool upVoted) => _$this._upVoted = upVoted;

  int _upVotes;
  int get upVotes => _$this._upVotes;
  set upVotes(int upVotes) => _$this._upVotes = upVotes;

  int _downVotes;
  int get downVotes => _$this._downVotes;
  set downVotes(int downVotes) => _$this._downVotes = downVotes;

  String _content;
  String get content => _$this._content;
  set content(String content) => _$this._content = content;

  PostBuilder();

  PostBuilder get _$this {
    if (_$v != null) {
      _tid = _$v.tid;
      _pid = _$v.pid;
      _uid = _$v.uid;
      _downVoted = _$v.downVoted;
      _upVoted = _$v.upVoted;
      _upVotes = _$v.upVotes;
      _downVotes = _$v.downVotes;
      _content = _$v.content;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Post other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Post;
  }

  @override
  void update(void updates(PostBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Post build() {
    final _$result = _$v ??
        new _$Post._(
            tid: tid,
            pid: pid,
            uid: uid,
            downVoted: downVoted,
            upVoted: upVoted,
            upVotes: upVotes,
            downVotes: downVotes,
            content: content);
    replace(_$result);
    return _$result;
  }
}
