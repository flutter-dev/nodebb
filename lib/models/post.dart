library post;
import 'package:flutter_wills_gen/wills.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/utils/utils.dart' as utils;
part 'post.g.dart';

@wills
abstract class Post extends Object with Reactive {

  int tid; //关联Topic ID

  int pid; //post id

  int uid; //用户 ID

  bool downVoted; //已踩

  bool upVoted; //已赞

  int upVotes; //点赞数

  int downVotes; //踩数

  String content; //内容

  Post.$();

  factory Post.fromMap(Map map) {
    Post post = new _$Post(
      content: map['content'],
      tid: utils.convertToInteger(map['tid']),
      pid: utils.convertToInteger(map['pid']),
      uid: utils.convertToInteger(map['uid']),
      downVotes: map['downvotes'],
      upVotes: map['upvotes'],
      upVoted: map['upvoted'],
      downVoted: map['downvoted'],
    );
    return post;
  }

  factory Post() = _$Post;
}