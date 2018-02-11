// GENERATED CODE - DO NOT MODIFY BY HAND

part of user;

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

class _$User extends User {
  @override
  final int uid;
  @override
  final String userName;
  @override
  final String status;
  @override
  final String picture;
  @override
  final int reputation;
  @override
  final int postCount;
  @override
  final String iconBgColor;
  @override
  final String iconText;
  @override
  final String signature;

  factory _$User([void updates(UserBuilder b)]) =>
      (new UserBuilder()..update(updates)).build();

  _$User._(
      {this.uid,
      this.userName,
      this.status,
      this.picture,
      this.reputation,
      this.postCount,
      this.iconBgColor,
      this.iconText,
      this.signature})
      : super._() {
    if (uid == null) throw new BuiltValueNullFieldError('User', 'uid');
    if (userName == null)
      throw new BuiltValueNullFieldError('User', 'userName');
    if (status == null) throw new BuiltValueNullFieldError('User', 'status');
    if (picture == null) throw new BuiltValueNullFieldError('User', 'picture');
    if (reputation == null)
      throw new BuiltValueNullFieldError('User', 'reputation');
    if (postCount == null)
      throw new BuiltValueNullFieldError('User', 'postCount');
    if (iconBgColor == null)
      throw new BuiltValueNullFieldError('User', 'iconBgColor');
    if (iconText == null)
      throw new BuiltValueNullFieldError('User', 'iconText');
    if (signature == null)
      throw new BuiltValueNullFieldError('User', 'signature');
  }

  @override
  User rebuild(void updates(UserBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! User) return false;
    return uid == other.uid &&
        userName == other.userName &&
        status == other.status &&
        picture == other.picture &&
        reputation == other.reputation &&
        postCount == other.postCount &&
        iconBgColor == other.iconBgColor &&
        iconText == other.iconText &&
        signature == other.signature;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, uid.hashCode), userName.hashCode),
                                status.hashCode),
                            picture.hashCode),
                        reputation.hashCode),
                    postCount.hashCode),
                iconBgColor.hashCode),
            iconText.hashCode),
        signature.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('User')
          ..add('uid', uid)
          ..add('userName', userName)
          ..add('status', status)
          ..add('picture', picture)
          ..add('reputation', reputation)
          ..add('postCount', postCount)
          ..add('iconBgColor', iconBgColor)
          ..add('iconText', iconText)
          ..add('signature', signature))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User _$v;

  int _uid;
  int get uid => _$this._uid;
  set uid(int uid) => _$this._uid = uid;

  String _userName;
  String get userName => _$this._userName;
  set userName(String userName) => _$this._userName = userName;

  String _status;
  String get status => _$this._status;
  set status(String status) => _$this._status = status;

  String _picture;
  String get picture => _$this._picture;
  set picture(String picture) => _$this._picture = picture;

  int _reputation;
  int get reputation => _$this._reputation;
  set reputation(int reputation) => _$this._reputation = reputation;

  int _postCount;
  int get postCount => _$this._postCount;
  set postCount(int postCount) => _$this._postCount = postCount;

  String _iconBgColor;
  String get iconBgColor => _$this._iconBgColor;
  set iconBgColor(String iconBgColor) => _$this._iconBgColor = iconBgColor;

  String _iconText;
  String get iconText => _$this._iconText;
  set iconText(String iconText) => _$this._iconText = iconText;

  String _signature;
  String get signature => _$this._signature;
  set signature(String signature) => _$this._signature = signature;

  UserBuilder();

  UserBuilder get _$this {
    if (_$v != null) {
      _uid = _$v.uid;
      _userName = _$v.userName;
      _status = _$v.status;
      _picture = _$v.picture;
      _reputation = _$v.reputation;
      _postCount = _$v.postCount;
      _iconBgColor = _$v.iconBgColor;
      _iconText = _$v.iconText;
      _signature = _$v.signature;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$User;
  }

  @override
  void update(void updates(UserBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$User build() {
    final _$result = _$v ??
        new _$User._(
            uid: uid,
            userName: userName,
            status: status,
            picture: picture,
            reputation: reputation,
            postCount: postCount,
            iconBgColor: iconBgColor,
            iconText: iconText,
            signature: signature);
    replace(_$result);
    return _$result;
  }
}
