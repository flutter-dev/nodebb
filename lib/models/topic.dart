library topic;
import 'package:flutter_wills_gen/wills.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/utils/utils.dart' as utils;
part 'topic.g.dart';

@wills
abstract class Topic extends Object with Reactive {

  int cid; //分类 ID

  int tid; //Topic ID

  int uid; //用户 ID

  bool isOwner;

  String title;

  DateTime lastPostTime; //最后回复

  int postCount;

  DateTime timestamp; //发布时间

  int viewCount; //阅读次数

  int upVotes; //点赞

  int downVotes; //踩

  ObservableList<int> posts; //posts

  Topic.$();

  factory Topic.fromMap(Map map) {
    Topic topic = new  _$Topic(
      tid: utils.convertToInteger(map['tid']),
      isOwner: map['isOwner'],
      cid: utils.convertToInteger(map['cid']),
      lastPostTime: new DateTime.fromMicrosecondsSinceEpoch(map['lastposttime']),
      downVotes: map['downvotes'],
      upVotes: map['upvotes'],
      timestamp: new DateTime.fromMicrosecondsSinceEpoch(map['timestamp']),
      postCount: map['postcount'],
      viewCount: map['viewcount'],
      title: map['title'],
      uid: utils.convertToInteger(map['uid'])
    );
    return topic;
  }

  factory Topic() = _$Topic;
}