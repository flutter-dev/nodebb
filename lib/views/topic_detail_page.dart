import 'package:flutter/material.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/enums/enums.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/services/remote_service.dart';
import 'package:nodebb/utils/utils.dart' as utils;
import 'package:nodebb/views/base.dart';
import 'package:nodebb/widgets/widgets.dart';

class TopicDetailPage extends BaseReactivePage {
  TopicDetailPage({key, routeParams}): super(key: key, routeParams: routeParams);

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
    fetchContent();
  }

  void fetchContent() {
    status.self = RequestStatus.PENDING;
    RemoteService.getInstance().fetchTopicDetail(tid).then((Map data) {
      List postsFromData = data['posts'] ?? [];
      for(var data in postsFromData) {
        posts.add(new Post.fromMap(data));
      }
      //post.self = new Post.fromMap(postsFromData[0]);
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
    switch(status.self) {
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
                  var state = context.ancestorStateOfType(const TypeMatcher<_TopicDetailState>()) as _TopicDetailState;
                  state.fetchContent();
                },
                child: new Text('重试'),
              )
            ],
          )
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

  final ObservableList<Post> posts;

  TopicContent({this.posts});

  @override
  Widget build(BuildContext context) {
    List<Widget> additionalChildren = [];
    additionalChildren.add(new Row(
//      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Expanded(
          child: new Align(
            child: new Container(
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [new BoxShadow(color: Colors.black45, blurRadius: 2.0)],
                color: Colors.red
              ),
              width: 90.0,
              height: 90.0,
              child: new Text('点赞', style: new TextStyle(fontSize: 24.0, color: Colors.white),),
            )
          )
        ),
        new Expanded(
          child: new Align(
            child: new Container(
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
                boxShadow: [new BoxShadow(color: Colors.black45, blurRadius: 2.0)],
              ),
              width: 90.0,
              height: 90.0,
              child: new Text('收藏', style: new TextStyle(fontSize: 24.0, color: Colors.white),),
            )
          )
        ),
        new Expanded(
            child: new Align(
              child: new Container(
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  boxShadow: [new BoxShadow(color: Colors.black45, blurRadius: 2.0)],
                ),
                width: 90.0,
                height: 90.0,
                child: new Text('评论', style: new TextStyle(fontSize: 24.0, color: Colors.white),),
              )
            )
        ),

      ],
    ));
    return new Markdown(data: posts[0].content, additionalChildren: additionalChildren);
//    return new ListView.builder(
//      itemBuilder: (BuildContext context, int index) {
//        if(index == 0 && posts[0] != null) {
//          return new MarkdownBody(data: posts[0].content ?? '');
//        } else {
//          return new Container();
//        }
//      }
//    );
  }

}