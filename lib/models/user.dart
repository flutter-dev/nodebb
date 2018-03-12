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

  factory User.fromMap(Map map) {
    User user = new _$User(
      userName: map['username'],
      uid: utils.convertToInteger(map['uid']),
      topicCount: map['topiccount'] ?? 0,
      picture: map['picture'],
      reputation: map['reputation'],
      status: map['status'],
      signature: map['signature'],
      iconText: map['icon:text'],
      iconBgColor: map['icon:bgColor'],
      cover: map['cover:url'],
      followerCount: utils.convertToInteger(map['followerCount']),
      followingCount: utils.convertToInteger(map['followingCount'])
    );
    return user;
  }

  factory User() = _$User;
}