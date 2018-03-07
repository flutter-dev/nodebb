// GENERATED CODE - DO NOT MODIFY BY HAND

part of app_state;

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

class _$AppState extends AppState {
  @override
  final int activeUser;
  @override
  final Collection<int, Topic> topics;
  @override
  final Collection<int, User> users;
  @override
  final Collection<int, Category> categories;
  @override
  final Collection<int, Post> posts;
  @override
  final RequestStatus fetchTopicStatus;
  @override
  final RequestStatus fetchTopicDetailStatus;
  @override
  final RequestStatus fetchUserStatus;
  @override
  final RequestStatus doLoginStatus;

  factory _$AppState([void updates(AppStateBuilder b)]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._(
      {this.activeUser,
      this.topics,
      this.users,
      this.categories,
      this.posts,
      this.fetchTopicStatus,
      this.fetchTopicDetailStatus,
      this.fetchUserStatus,
      this.doLoginStatus})
      : super._() {
    if (topics == null)
      throw new BuiltValueNullFieldError('AppState', 'topics');
    if (users == null) throw new BuiltValueNullFieldError('AppState', 'users');
    if (categories == null)
      throw new BuiltValueNullFieldError('AppState', 'categories');
    if (posts == null) throw new BuiltValueNullFieldError('AppState', 'posts');
    if (fetchTopicStatus == null)
      throw new BuiltValueNullFieldError('AppState', 'fetchTopicStatus');
    if (fetchTopicDetailStatus == null)
      throw new BuiltValueNullFieldError('AppState', 'fetchTopicDetailStatus');
    if (fetchUserStatus == null)
      throw new BuiltValueNullFieldError('AppState', 'fetchUserStatus');
    if (doLoginStatus == null)
      throw new BuiltValueNullFieldError('AppState', 'doLoginStatus');
  }

  @override
  AppState rebuild(void updates(AppStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! AppState) return false;
    return activeUser == other.activeUser &&
        topics == other.topics &&
        users == other.users &&
        categories == other.categories &&
        posts == other.posts &&
        fetchTopicStatus == other.fetchTopicStatus &&
        fetchTopicDetailStatus == other.fetchTopicDetailStatus &&
        fetchUserStatus == other.fetchUserStatus &&
        doLoginStatus == other.doLoginStatus;
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
                                $jc($jc(0, activeUser.hashCode),
                                    topics.hashCode),
                                users.hashCode),
                            categories.hashCode),
                        posts.hashCode),
                    fetchTopicStatus.hashCode),
                fetchTopicDetailStatus.hashCode),
            fetchUserStatus.hashCode),
        doLoginStatus.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('activeUser', activeUser)
          ..add('topics', topics)
          ..add('users', users)
          ..add('categories', categories)
          ..add('posts', posts)
          ..add('fetchTopicStatus', fetchTopicStatus)
          ..add('fetchTopicDetailStatus', fetchTopicDetailStatus)
          ..add('fetchUserStatus', fetchUserStatus)
          ..add('doLoginStatus', doLoginStatus))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  int _activeUser;
  int get activeUser => _$this._activeUser;
  set activeUser(int activeUser) => _$this._activeUser = activeUser;

  CollectionBuilder<int, Topic> _topics;
  CollectionBuilder<int, Topic> get topics =>
      _$this._topics ??= new CollectionBuilder<int, Topic>();
  set topics(CollectionBuilder<int, Topic> topics) => _$this._topics = topics;

  CollectionBuilder<int, User> _users;
  CollectionBuilder<int, User> get users =>
      _$this._users ??= new CollectionBuilder<int, User>();
  set users(CollectionBuilder<int, User> users) => _$this._users = users;

  CollectionBuilder<int, Category> _categories;
  CollectionBuilder<int, Category> get categories =>
      _$this._categories ??= new CollectionBuilder<int, Category>();
  set categories(CollectionBuilder<int, Category> categories) =>
      _$this._categories = categories;

  CollectionBuilder<int, Post> _posts;
  CollectionBuilder<int, Post> get posts =>
      _$this._posts ??= new CollectionBuilder<int, Post>();
  set posts(CollectionBuilder<int, Post> posts) => _$this._posts = posts;

  RequestStatusBuilder _fetchTopicStatus;
  RequestStatusBuilder get fetchTopicStatus =>
      _$this._fetchTopicStatus ??= new RequestStatusBuilder();
  set fetchTopicStatus(RequestStatusBuilder fetchTopicStatus) =>
      _$this._fetchTopicStatus = fetchTopicStatus;

  RequestStatusBuilder _fetchTopicDetailStatus;
  RequestStatusBuilder get fetchTopicDetailStatus =>
      _$this._fetchTopicDetailStatus ??= new RequestStatusBuilder();
  set fetchTopicDetailStatus(RequestStatusBuilder fetchTopicDetailStatus) =>
      _$this._fetchTopicDetailStatus = fetchTopicDetailStatus;

  RequestStatusBuilder _fetchUserStatus;
  RequestStatusBuilder get fetchUserStatus =>
      _$this._fetchUserStatus ??= new RequestStatusBuilder();
  set fetchUserStatus(RequestStatusBuilder fetchUserStatus) =>
      _$this._fetchUserStatus = fetchUserStatus;

  RequestStatusBuilder _doLoginStatus;
  RequestStatusBuilder get doLoginStatus =>
      _$this._doLoginStatus ??= new RequestStatusBuilder();
  set doLoginStatus(RequestStatusBuilder doLoginStatus) =>
      _$this._doLoginStatus = doLoginStatus;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _activeUser = _$v.activeUser;
      _topics = _$v.topics?.toBuilder();
      _users = _$v.users?.toBuilder();
      _categories = _$v.categories?.toBuilder();
      _posts = _$v.posts?.toBuilder();
      _fetchTopicStatus = _$v.fetchTopicStatus?.toBuilder();
      _fetchTopicDetailStatus = _$v.fetchTopicDetailStatus?.toBuilder();
      _fetchUserStatus = _$v.fetchUserStatus?.toBuilder();
      _doLoginStatus = _$v.doLoginStatus?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$AppState;
  }

  @override
  void update(void updates(AppStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
              activeUser: activeUser,
              topics: topics.build(),
              users: users.build(),
              categories: categories.build(),
              posts: posts.build(),
              fetchTopicStatus: fetchTopicStatus.build(),
              fetchTopicDetailStatus: fetchTopicDetailStatus.build(),
              fetchUserStatus: fetchUserStatus.build(),
              doLoginStatus: doLoginStatus.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'topics';
        topics.build();
        _$failedField = 'users';
        users.build();
        _$failedField = 'categories';
        categories.build();
        _$failedField = 'posts';
        posts.build();
        _$failedField = 'fetchTopicStatus';
        fetchTopicStatus.build();
        _$failedField = 'fetchTopicDetailStatus';
        fetchTopicDetailStatus.build();
        _$failedField = 'fetchUserStatus';
        fetchUserStatus.build();
        _$failedField = 'doLoginStatus';
        doLoginStatus.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
