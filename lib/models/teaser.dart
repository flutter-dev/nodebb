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

  factory Teaser.fromJSON(Map json) {
    Teaser teaser = new _$Teaser(
      fromUser: json['user'] != null ? new User.fromJSON(json['user']) : null,
      content: json['content'] ?? '',
      timestamp: json['timestamp'] ?? 0
    );
    return teaser;
  }

  factory Teaser() = _$Teaser;

}