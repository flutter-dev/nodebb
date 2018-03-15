// GENERATED CODE - DO NOT MODIFY BY HAND

part of user;

// **************************************************************************
// Generator: WillsGenerator
// **************************************************************************

class _$User extends User {
  int _uid;
  int get uid {
    $observe('uid');
    _uid = _uid ?? 0;
    return _uid;
  }

  set uid(int uid) {
    if (uid != null && uid == _uid) return;
    _uid = uid;
    $notify('uid');
  }

  String _userName;
  String get userName {
    $observe('userName');
    _userName = _userName ?? '';
    return _userName;
  }

  set userName(String userName) {
    if (userName != null && userName == _userName) return;
    _userName = userName;
    $notify('userName');
  }

  String _status;
  String get status {
    $observe('status');
    _status = _status ?? '';
    return _status;
  }

  set status(String status) {
    if (status != null && status == _status) return;
    _status = status;
    $notify('status');
  }

  String _picture;
  String get picture {
    $observe('picture');
    _picture = _picture ?? '';
    return _picture;
  }

  set picture(String picture) {
    if (picture != null && picture == _picture) return;
    _picture = picture;
    $notify('picture');
  }

  String _cover;
  String get cover {
    $observe('cover');
    _cover = _cover ?? '';
    return _cover;
  }

  set cover(String cover) {
    if (cover != null && cover == _cover) return;
    _cover = cover;
    $notify('cover');
  }

  int _followerCount;
  int get followerCount {
    $observe('followerCount');
    _followerCount = _followerCount ?? 0;
    return _followerCount;
  }

  set followerCount(int followerCount) {
    if (followerCount != null && followerCount == _followerCount) return;
    _followerCount = followerCount;
    $notify('followerCount');
  }

  int _followingCount;
  int get followingCount {
    $observe('followingCount');
    _followingCount = _followingCount ?? 0;
    return _followingCount;
  }

  set followingCount(int followingCount) {
    if (followingCount != null && followingCount == _followingCount) return;
    _followingCount = followingCount;
    $notify('followingCount');
  }

  int _reputation;
  int get reputation {
    $observe('reputation');
    _reputation = _reputation ?? 0;
    return _reputation;
  }

  set reputation(int reputation) {
    if (reputation != null && reputation == _reputation) return;
    _reputation = reputation;
    $notify('reputation');
  }

  int _topicCount;
  int get topicCount {
    $observe('topicCount');
    _topicCount = _topicCount ?? 0;
    return _topicCount;
  }

  set topicCount(int topicCount) {
    if (topicCount != null && topicCount == _topicCount) return;
    _topicCount = topicCount;
    $notify('topicCount');
  }

  String _iconBgColor;
  String get iconBgColor {
    $observe('iconBgColor');
    _iconBgColor = _iconBgColor ?? '';
    return _iconBgColor;
  }

  set iconBgColor(String iconBgColor) {
    if (iconBgColor != null && iconBgColor == _iconBgColor) return;
    _iconBgColor = iconBgColor;
    $notify('iconBgColor');
  }

  String _iconText;
  String get iconText {
    $observe('iconText');
    _iconText = _iconText ?? '';
    return _iconText;
  }

  set iconText(String iconText) {
    if (iconText != null && iconText == _iconText) return;
    _iconText = iconText;
    $notify('iconText');
  }

  String _signature;
  String get signature {
    $observe('signature');
    _signature = _signature ?? '';
    return _signature;
  }

  set signature(String signature) {
    if (signature != null && signature == _signature) return;
    _signature = signature;
    $notify('signature');
  }

  _$User.$() : super.$();
  factory _$User({
    int uid: 0,
    String userName: '',
    String status: '',
    String picture: '',
    String cover: '',
    int followerCount: 0,
    int followingCount: 0,
    int reputation: 0,
    int topicCount: 0,
    String iconBgColor: '',
    String iconText: '',
    String signature: '',
  }) {
    return new _$User.$()
      .._uid = uid
      .._userName = userName
      .._status = status
      .._picture = picture
      .._cover = cover
      .._followerCount = followerCount
      .._followingCount = followingCount
      .._reputation = reputation
      .._topicCount = topicCount
      .._iconBgColor = iconBgColor
      .._iconText = iconText
      .._signature = signature;
  }
}
