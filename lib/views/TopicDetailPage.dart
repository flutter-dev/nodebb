import 'package:built_collection/built_collection.dart';
import 'package:built_redux/built_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';
import 'package:nodebb/actions/actions.dart';
import 'package:nodebb/models/app_state.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/views/BasePage.dart';
import 'package:nodebb/utils/utils.dart' as utils;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nodebb/application/application.dart';

class TopicDetailPage extends BasePage {
  TopicDetailPage({key, routeParams}): super(key: key, routeParams: routeParams);

  @override
  _TopicDetailState createState() {
    return new _TopicDetailState();
  }
}

class _TopicDetailState extends State<TopicDetailPage> {
  int tid;
  @override
  void initState() {
    tid = utils.convertToInteger(widget.routeParams['tid']);
    fetchContent();
  }

  void fetchContent() {
    Application.store.actions.fetchTopicDetail(tid);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text('${Application.store.state.topics.entities[tid].title}')
      ),
      body: new TopicContent(tid: tid)
    );
  }

}

class TopicContent extends StoreConnector<AppState, AppActions, BuiltMap<String, Object>> {

  final tid;
  TopicContent({key, tid}): tid = tid, super(key: key);

  @override
  BuiltMap<String, Object> connect(AppState state) {
    int pid = state.topics.entities[tid]?.posts?.elementAt(0);
    BuiltMap<String, Object> localState = new BuiltMap<String, Object>.build((b) {
      b.putIfAbsent('content', ()=> state.posts.entities[pid]?.content ?? '');
      b.putIfAbsent('fetchTopicDetailStatus', ()=> state.fetchTopicDetailStatus);
    });
    return localState;
  }

  @override
  Widget build(BuildContext context, BuiltMap<String, Object> localState, AppActions actions) {
    var content = localState['content'] as String;
    var fetchTopicDetailStatus = localState['fetchTopicDetailStatus'] as RequestStatus;
    Widget child;
    switch(fetchTopicDetailStatus.status) {
      case $RequestStatus.SUCCESS:
        child = new Markdown(data: content);
        break;
      case $RequestStatus.ERROR:
        child = new Column(
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
      case $RequestStatus.PENDING:
      default:
        child = new Text('加载中...');
    }
    return new Center(
      child: child
    );
  }


}