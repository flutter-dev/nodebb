// GENERATED CODE - DO NOT MODIFY BY HAND

part of user;

// **************************************************************************
// Generator: WillsGenerator
// **************************************************************************

class _$User extends User {
  int _uid;
  int get uid {
    $observe('uid');
    return _uid;
  }

  set uid(int uid) {
    if (uid == _uid) return;
    _uid = uid;
    $notify('uid');
  }

  String _userName;
  String get userName {
    $observe('userName');
    return _userName;
  }

  set userName(String userName) {
    if (userName == _userName) return;
    _userName = userName;
    $notify('userName');
  }

  String _status;
  String get status {
    $observe('status');
    return _status;
  }

  set status(String status) {
    if (status == _status) return;
    _status = status;
    $notify('status');
  }

  String _picture;
  String get picture {
    $observe('picture');
    return _picture;
  }

  set picture(String picture) {
    if (picture == _picture) return;
    _picture = picture;
    $notify('picture');
  }

  String _cover;
  String get cover {
    $observe('cover');
    return _cover;
  }

  set cover(String cover) {
    if (cover == _cover) return;
    _cover = cover;
    $notify('cover');
  }

  int _followerCount;
  int get followerCount {
    $observe('followerCount');
    return _followerCount;
  }

  set followerCount(int followerCount) {
    if (followerCount == _followerCount) return;
    _followerCount = followerCount;
    $notify('followerCount');
  }

  int _followingCount;
  int get followingCount {
    $observe('followingCount');
    return _followingCount;
  }

  set followingCount(int followingCount) {
    if (followingCount == _followingCount) return;
    _followingCount = followingCount;
    $notify('followingCount');
  }

  int _reputation;
  int get reputation {
    $observe('reputation');
    return _reputation;
  }

  set reputation(int reputation) {
    if (reputation == _reputation) return;
    _reputation = reputation;
    $notify('reputation');
  }

  int _topicCount;
  int get topicCount {
    $observe('topicCount');
    return _topicCount;
  }

  set topicCount(int topicCount) {
    if (topicCount == _topicCount) return;
    _topicCount = topicCount;
    $notify('topicCount');
  }

  String _iconBgColor;
  String get iconBgColor {
    $observe('iconBgColor');
    return _iconBgColor;
  }

  set iconBgColor(String iconBgColor) {
    if (iconBgColor == _iconBgColor) return;
    _iconBgColor = iconBgColor;
    $notify('iconBgColor');
  }

  String _iconText;
  String get iconText {
    $observe('iconText');
    return _iconText;
  }

  set iconText(String iconText) {
    if (iconText == _iconText) return;
    _iconText = iconText;
    $notify('iconText');
  }

  String _signature;
  String get signature {
    $observe('signature');
    return _signature;
  }

  set signature(String signature) {
    if (signature == _signature) return;
    _signature = signature;
    $notify('signature');
  }

  _$User.$() : super.$();
  factory _$User({
    int uid,
    String userName,
    String status,
    String picture,
    String cover,
    int followerCount,
    int followingCount,
    int reputation,
    int topicCount,
    String iconBgColor,
    String iconText,
    String signature,
  }) {
    return new _$User.$()
      .._uid = uid ?? 0
      .._userName = userName ?? ''
      .._status = status ?? ''
      .._picture = picture ?? ''
      .._cover = cover ?? ''
      .._followerCount = followerCount ?? 0
      .._followingCount = followingCount ?? 0
      .._reputation = reputation ?? 0
      .._topicCount = topicCount ?? 0
      .._iconBgColor = iconBgColor ?? ''
      .._iconText = iconText ?? ''
      .._signature = signature ?? '';
  }
}
