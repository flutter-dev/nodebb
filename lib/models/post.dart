library post;
import 'package:flutter_wills_gen/wills.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/models/user.dart';
import 'package:nodebb/utils/utils.dart' as utils;
part 'post.g.dart';

@wills
abstract class Post extends Object with Reactive {

  int tid; //关联Topic ID

  int pid; //post id

  User user; //用户 ID

  bool downVoted; //已踩

  bool upVoted; //已赞

  int upVotes; //点赞数

  int downVotes; //踩数

  int votes; //赞总数

  DateTime timestamp;

  String content; //内容

  Post.$();

  factory Post.fromMap(Map map) {
    Post post = new _$Post(
      content: map['content'],
      tid: utils.convertToInteger(map['tid']),
      pid: utils.convertToInteger(map['pid']),
      user: new User.fromJson(map['user']),
      downVotes: map['downvotes'] ?? 0,
      upVotes: map['upvotes'] ?? 0,
      upVoted: map['upvoted'] ?? 0,
      downVoted: map['downvoted'] ?? 0,
      votes: map['votes'] ?? 0,
      timestamp: new DateTime.fromMillisecondsSinceEpoch(map['timestamp'])
    );
    return post;
  }

  factory Post() = _$Post;
}