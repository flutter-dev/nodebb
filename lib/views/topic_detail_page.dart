import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/actions/actions.dart';
import 'package:nodebb/enums/enums.dart';
import 'package:nodebb/errors/errors.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/services/io_service.dart';
import 'package:nodebb/services/remote_service.dart';
import 'package:nodebb/utils/utils.dart' as utils;
import 'package:nodebb/views/base.dart';
import 'package:nodebb/widgets/widgets.dart';

class TopicDetailPage extends BaseReactivePage {
  TopicDetailPage({key, routeParams})
      : super(key: key, routeParams: routeParams);

  @override
  _TopicDetailState createState() {
    return new _TopicDetailState();
  }
}

class _TopicDetailState extends BaseReactiveState<TopicDetailPage> {
  int tid;

  ObservableList<Post> posts = new ObservableList();

  ReactiveProp<Post> post = new ReactiveProp();

  ReactiveProp<RequestStatus> status = new ReactiveProp();

  @override
  void initState() {
    super.initState();
    tid = utils.convertToInteger(widget.routeParams['tid']);
    _fetchContent();
  }


  @override
  void didUpdateWidget(TopicDetailPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    int newTid = utils.convertToInteger(widget.routeParams['tid']);
    if(tid != newTid) {
      tid = newTid;
      _fetchContent();
    }
  }

  void _fetchContent() {
    status.self = RequestStatus.PENDING;
    RemoteService.getInstance().fetchTopicDetail(tid).then((Map data) {
      List postsFromData = data['posts'] ?? [];
      for (var data in postsFromData) {
        posts.add(new Post.fromMap(data));
      }
      status.self = RequestStatus.SUCCESS;
    }).catchError((err, stacktrace) {
      print(err);
      print(stacktrace);
      status.self = RequestStatus.ERROR;
    });
  }

  @override
  Widget render(BuildContext context) {
    Widget body;
    switch (status.self) {
      case RequestStatus.SUCCESS:
        body = new TopicContent(posts: posts);
        break;
      case RequestStatus.ERROR:
        body = new Center(
            child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('出错了！'),
            new MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                var state = context.ancestorStateOfType(
                        const TypeMatcher<_TopicDetailState>())
                    as _TopicDetailState;
                state?._fetchContent();
              },
              child: new Text('重试'),
            )
          ],
        ));
        break;
      default:
        body = new Center(child: new Text('加载中...'));
        break;
    }
    return new Scaffold(
        appBar:
            new AppBar(title: new Text('${$store.state.topics[tid].title}')),
        body: body);
  }
}

class TopicContent extends BaseReactiveWidget {

  final ObservableList<Post> posts;

  TopicContent({this.posts});

  @override
  BaseReactiveState<ReactiveWidget> createState() {
    return new _TopicContentState();
  }
}

class _TopicContentState extends BaseReactiveState<TopicContent> {

  _buildInfoBar() {
    Post post = widget.posts[0];
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Padding(
          child: const Divider(height: 1.0,),
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0)
        ),
        new Text(
            '${post.votes} 赞 · ${post.timestamp.year}-${post.timestamp.month}-${post.timestamp.day}',
          style: const TextStyle(color: Colors.grey),
        )
      ],
    );
  }

  _buildOptionBar() {
    Post post = widget.posts[0];
    return new Container(
      padding: new EdgeInsets.only(top: 32.0, bottom: 16.0),
      child: new ButtonTheme(
        shape: new CircleBorder(),
        minWidth: 90.0,
        height: 90.0,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Align(
                child: new MaterialButton(
                  onPressed: () {
                    if($store.state.activeUser == null) {
                      $confirm('点赞需要先登录~', onConfirm: () {
                        new Timer(const Duration(milliseconds: 300), () {
                          Navigator.of(context).pushNamed('/login');
                        });
                      }, onConfirmBtnTxt: '登录');
                    } else if($store.state.activeUser.uid == post.user.uid) {
                      Scaffold.of(context).showSnackBar(new SnackBar(
                        content: new Text('提示：不可以点赞自己的文章'),
                        backgroundColor: Colors.blue,
                      ));
                    } else if(post.upVoted) {
                      Scaffold.of(context).showSnackBar(new SnackBar(
                        content: new Text('提示：你已点赞过该文章'),
                        backgroundColor: Colors.blue,
                      ));
                    } else {
                      IOService.getInstance().upvote(post.tid, post.pid).then((int votes) {
                        post.votes = votes;
                        Scaffold.of(context).showSnackBar(new SnackBar(
                          content: new Text('点赞+1！'),
                          backgroundColor: Colors.green,
                        ));
                      }).catchError((err) {
                        Scaffold.of(context).showSnackBar(new SnackBar(
                          content: new Text('点赞失败！请重新尝试'),
                          backgroundColor: Colors.red,
                        ));
                      });
                    }
                  },
                  color: Colors.red,
                  child: new Text('点赞',
                      style: new TextStyle(fontSize: 24.0, color: Colors.white)
                  )
                ),
              )
            ),
            new Expanded(
              child: new Align(
                child: new MaterialButton(
                  onPressed: () {
                    $checkLogin().then((_) {
                      $store.dispatch(new DoBookmarkAction(topicId: post.tid, postId: post.pid)).then((_) {
                        Scaffold.of(context).showSnackBar(new SnackBar(
                          content: new Text('收藏成功！'),
                          backgroundColor: Colors.green,
                        ));
                      }).catchError((err) {
                        if(err is NodeBBBookmarkedException) {
                          Scaffold.of(context).showSnackBar(new SnackBar(
                            content: new Text('提示：你已收藏过该文章'),
                            backgroundColor: Colors.blue,
                          ));
                        } else {
                          Scaffold.of(context).showSnackBar(new SnackBar(
                            content: new Text('收藏失败！请重新尝试'),
                            backgroundColor: Colors.red,
                          ));
                        }
                      });
                    });
                  },
                  color: Colors.green,
                  child: new Text('收藏', style: new TextStyle(fontSize: 24.0, color: Colors.white))
                )
              )
            ),
            new Expanded(
              child: new Align(
                child: new MaterialButton(
                  onPressed: () {
                    if($store.state.activeUser == null) {
                      $confirm('评论需要先登录~', onConfirm: () {
                        new Timer(const Duration(milliseconds: 300), () {
                          Navigator.of(context).pushNamed('/login');
                        });
                      }, onConfirmBtnTxt: '登录');
                    } else {
                      Navigator.of(context).pushNamed('/comment/${post.tid}').then((post) {
                        if(post is Post) {
                          $store.state.topics[post.tid].postCount++; //todo use mutation
                          widget.posts.add(post);
                        }
                      });
                    }
                  },
                  color: Colors.blue,
                  child: new Text('回复', style: new TextStyle(fontSize: 24.0, color: Colors.white))
                )
              )
            ),
          ],
        )
      )
    );
  }

  _buildComments() {
    List<Widget> comments = [];
    widget.posts.skip(1).forEach((Post post) {
      comments.add(new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            width: 42.0,
            height: 42.0,
            margin: const EdgeInsets.only(right: 12.0),
            alignment: Alignment.topCenter,
            child: new NodeBBAvatar(
              picture: post.user.picture,
              iconBgColor: post.user.iconBgColor,
              iconText: post.user.iconText,
            ),
          ),
          new Expanded(
            child:
            new Column(
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text('${post.user.userName}:', style: const TextStyle(fontSize: 14.0),),
                      new Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                        child: new Text(post.content, style: const TextStyle(fontSize: 14.0),),
                      ),
                      new Align(
                        alignment: Alignment.bottomRight,
                        child: new Text(
                          '${post.timestamp.year}-${post.timestamp.month}-${post.timestamp.day}',
                          style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                        )
                      )
                    ],
                  ),
                ),
                new Divider(height: 1.0,)
              ],
            )
          )
        ],
      ));
    });
    return comments;
  }

  @override
  Widget render(BuildContext context) {
    List<Widget> additionalChildren = [];
    additionalChildren.add(_buildInfoBar());
    additionalChildren.add(_buildOptionBar());
    additionalChildren.addAll(_buildComments());
    return new Markdown(data: widget.posts[0].content, additionalChildren: additionalChildren);
  }
}
