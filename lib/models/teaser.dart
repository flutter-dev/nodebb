library teaser;

import 'package:flutter_wills/flutter_wills.dart';
import 'package:flutter_wills_gen/wills.dart';
import 'package:nodebb/models/user.dart';

part 'teaser.g.dart';

@wills
class Teaser extends Object with Reactive {

  User fromUser;

  String content;

  int timestamp;

  Teaser.$();

  factory Teaser.fromJson(Map json) {
    Teaser teaser = new _$Teaser(
      fromUser: new User.fromJson(json['user']),
      content: json['content'],
      timestamp: json['timestamp']
    );
    return teaser;
  }

  factory Teaser() = _$Teaser;

}