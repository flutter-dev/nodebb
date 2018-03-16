library topic;
import 'package:flutter_wills_gen/wills.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/models/post.dart';
import 'package:nodebb/models/user.dart';
import 'package:nodebb/utils/utils.dart' as utils;
part 'topic.g.dart';

@wills
abstract class Topic extends Object with Reactive {

  int cid; //分类 ID

  int tid; //Topic ID

  User user;

  bool isOwner;

  String title;

  DateTime lastPostTime; //最后回复

  int postCount;

  DateTime timestamp; //发布时间

  int viewCount; //阅读次数

  int upVotes; //点赞

  int downVotes; //踩

//  ObservableList<Post> posts; //posts

  Topic.$();

  factory Topic.fromJson(Map json) {
    Topic topic = new  _$Topic(
      tid: utils.convertToInteger(json['tid']),
      isOwner: json['isOwner'],
      cid: utils.convertToInteger(json['cid']),
      lastPostTime: new DateTime.fromMicrosecondsSinceEpoch(json['lastposttime']),
      downVotes: json['downvotes'],
      upVotes: json['upvotes'],
      timestamp: new DateTime.fromMicrosecondsSinceEpoch(json['timestamp']),
      postCount: json['postcount'],
      viewCount: json['viewcount'],
      title: json['title'],
      //uid: utils.convertToInteger(json['uid'])
      user: new User.fromJson(json['user'])
    );
    return topic;
  }

  factory Topic() = _$Topic;
}