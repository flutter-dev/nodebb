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

  bool isMainPost;

  DateTime timestamp;

  String content; //内容

  Post.$();

  factory Post.fromJSON(Map json) {
    Post post = new _$Post(
      content: json['content'],
      tid: utils.convertToInteger(json['tid']),
      pid: utils.convertToInteger(json['pid']),
      user: json['user'] != null ? new User.fromJSON(json['user']) : null,
      downVotes: json['downvotes'] ?? 0,
      upVotes: json['upvotes'] ?? 0,
      upVoted: json['upvoted'] ?? false,
      downVoted: json['downvoted'] ?? false,
      isMainPost: json['isMainPost'] ?? false,
      votes: json['votes'] ?? 0,
      timestamp: new DateTime.fromMillisecondsSinceEpoch(json['timestamp'])
    );
    return post;
  }

  factory Post() = _$Post;
}