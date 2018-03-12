import 'package:flutter/material.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/enums/enums.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/services/remote_service.dart';
import 'package:nodebb/utils/utils.dart' as utils;
import 'package:nodebb/views/base.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TopicDetailPage extends BaseReactivePage {
  TopicDetailPage({key, routeParams}): super(key: key, routeParams: routeParams);

  @override
  _TopicDetailState createState() {
    return new _TopicDetailState();
  }
}

class _TopicDetailState extends BaseReactiveState<TopicDetailPage> {

  int tid;

  ObservableState<Post> post = new ObservableState();

  ObservableState<RequestStatus> status = new ObservableState();

  @override
  void initState() {
    super.initState();
    tid = utils.convertToInteger(widget.routeParams['tid']);
    fetchContent();
  }

  void fetchContent() {
    status.self = RequestStatus.PENDING;
    RemoteService.getInstance().fetchTopicDetail(tid).then((Map data) {
      List postsFromData = data['posts'] ?? [];
      post.self = new Post.fromMap(postsFromData[0]);
      status.self = RequestStatus.SUCCESS;
    }).catchError((err) {
      status.self = RequestStatus.ERROR;
    });
  }

  @override
  Widget render(BuildContext context) {
    Widget body;
    switch(status.self) {
      case RequestStatus.SUCCESS:
        body = new TopicContent(content: post.self?.content ?? '');
        break;
      case RequestStatus.ERROR:
        body = new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('出错了！'),
            new MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                var state = context.ancestorStateOfType(const TypeMatcher<_TopicDetailState>()) as _TopicDetailState;
                state.fetchContent();
              },
              child: new Text('重试'),
            )
          ],
        );
        break;
      default:
        body = new Center(
          child:  new Text('加载中...')
        );
        break;
    }
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('${$store.state.topics[tid].title}')
      ),
      body: body
    );
  }

}

class TopicContent extends StatelessWidget {

  final String content;

  TopicContent({this.content = ''});

  @override
  Widget build(BuildContext context) {
    return new Markdown(data: content);
  }

}