library post;
import 'package:built_value/built_value.dart';
import 'package:nodebb/utils/utils.dart' as utils;

part 'post.g.dart';

abstract class Post implements Built<Post, PostBuilder> {

  int get tid; //关联Topic ID

  int get pid; //post id

  int get uid; //用户 ID

  bool get downVoted; //已踩

  bool get upVoted; //已赞

  int get upVotes; //点赞数

  int get downVotes; //踩数

  String get content; //内容

  factory Post.fromMap(Map post) {
    return new Post((PostBuilder builder) {
      builder.content = post['content'];
      builder.tid = utils.convertToInteger(post['tid']);
      builder.pid = utils.convertToInteger(post['pid']);
      builder.uid = utils.convertToInteger(post['uid']);
      builder.downVotes = post['downvotes'];
      builder.upVotes = post['upvotes'];
      builder.upVoted = post['upvoted'];
      builder.downVoted = post['downvoted'];
    });
  }

  Post._();
  factory Post([updates(PostBuilder b)]) = _$Post;
}