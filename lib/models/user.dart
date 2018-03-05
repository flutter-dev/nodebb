library user;
import 'package:built_value/built_value.dart';
import 'package:nodebb/utils/utils.dart' as utils;
part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {

  int get uid;

  String get userName;

  String get status;

  String get picture;

  @nullable
  String get cover; //封面

  @nullable
  int get followerCount; //粉丝

  @nullable
  int get followingCount; //关注

  int get reputation; //声望

  int get postCount; //文章数量

  String get iconBgColor;

  String get iconText;

  String get signature; //签名

  factory User.fromMap(Map user) {
    return new User((UserBuilder builder) {
      builder.userName = user['username'];
      builder.uid = utils.convertToInteger(user['uid']);
      builder.postCount = user['postcount'];
      builder.picture = user['picture'];
      builder.reputation = user['reputation'];
      builder.status = user['status'];
      builder.signature = user['signature'];
      builder.iconText = user['icon:text'];
      builder.iconBgColor = user['icon:bgColor'];
      builder.cover = user['cover:url'];
      builder.followerCount = utils.convertToInteger(user['followerCount']);
      builder.followingCount = utils.convertToInteger(user['followingCount']);
    });
  }

  User._();

  factory User([updates(UserBuilder b)]) = _$User;
}