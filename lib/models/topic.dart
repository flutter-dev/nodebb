library topic;
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nodebb/utils/utils.dart' as utils;
part 'topic.g.dart';

abstract class Topic implements Built<Topic, TopicBuilder> {

  int get cid; //分类 ID

  int get tid; //Topic ID

  int get uid; //用户 ID

  bool get isOwner;

  String get title;

  DateTime get lastPostTime; //最后回复

  int get postCount;

  DateTime get timestamp; //发布时间

  int get viewCount; //阅读次数

  int get upVotes; //点赞

  int get downVotes; //踩

  @nullable
  BuiltList<int> get posts; //posts

  factory Topic.fromMap(Map topic) {
    return new Topic((TopicBuilder builder) {
      builder.tid = utils.convertToInteger(topic['tid']);
      builder.isOwner = topic['isOwner'];
      builder.cid =  utils.convertToInteger(topic['cid']);
      builder.lastPostTime = new DateTime.fromMicrosecondsSinceEpoch(topic['lastposttime']);
      builder.downVotes = topic['downvotes'];
      builder.upVotes = topic['upvotes'];
      builder.timestamp = new DateTime.fromMicrosecondsSinceEpoch(topic['timestamp']);
      builder.postCount = topic['postcount'];
      builder.viewCount = topic['viewcount'];
      builder.title = topic['title'];
      builder.uid = utils.convertToInteger(topic['uid']);
    });
  }

  Topic._();
  factory Topic([updates(TopicBuilder b)]) = _$Topic;
}