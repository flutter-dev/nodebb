library user;
import 'package:flutter_wills_gen/wills.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/utils/utils.dart' as utils;

part 'user.g.dart';

@wills
abstract class User extends Object with Reactive {

  int get uid;

  String get userName;

  String get status;

  String get picture;

  String get cover; //封面

  int get followerCount; //粉丝

  int get followingCount; //关注

  int get reputation; //声望

  int get topicCount; //主题数量

  String get iconBgColor;

  String get iconText;

  String get signature; //签名

  User.$();

  factory User.fromJson(Map json) {
    User user = new _$User(
      userName: json['username'],
      uid: utils.convertToInteger(json['uid']),
      topicCount: json['topiccount'] ?? 0,
      picture: json['picture'],
      reputation: json['reputation'] ?? 0,
      status: json['status'],
      signature: json['signature'] ?? '',
      iconText: json['icon:text'],
      iconBgColor: json['icon:bgColor'],
      cover: json['cover:url'] ?? '',
      followerCount: utils.convertToInteger(json['followerCount'] ?? 0),
      followingCount: utils.convertToInteger(json['followingCount'] ?? 0)
    );
    return user;
  }

  factory User() = _$User;
}