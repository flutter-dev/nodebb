import 'package:built_redux/built_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';
import 'package:nodebb/actions/actions.dart';
import 'package:nodebb/models/app_state.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/views/BasePage.dart';
import 'package:nodebb/utils/utils.dart' as utils;
import 'package:flutter_markdown/flutter_markdown.dart';

class TopicDetailPage extends BasePage {
  TopicDetailPage({key, routeParams}): super(key: key, routeParams: routeParams);

  @override
  _TopicDetailState createState() {
    return new _TopicDetailState();
  }
}

class _TopicDetailState extends State<TopicDetailPage> {

  @override
  Widget build(BuildContext context) {
    var tid = utils.convertToInteger(widget.routeParams['tid']);
    ReduxProvider provider = context.inheritFromWidgetOfExactType(ReduxProvider);
    Store<AppState, AppStateBuilder, AppActions> store = provider.store;
    store.actions.fetchTopicDetail(tid);
    return new Scaffold(
      appBar: new AppBar(
          title: new Text('${store.state.topics.entities[tid].title}')
      ),
      body: new TopicContent(tid: tid)
    );
  }

}

class TopicContent extends StoreConnector<AppState, AppActions, String> {

  final tid;
  TopicContent({key, tid}): tid = tid, super(key: key);

  @override
  String connect(AppState state) {
    int pid = state.topics.entities[tid]?.posts?.elementAt(0);
    //print(state.topics.entities[tid]);
    return state.posts.entities[pid]?.content;
  }

  @override
  Widget build(BuildContext context, String state, AppActions actions) {
    return new Center(
      child: state == null
          ? new Text('加载中...')
          : new Markdown(data: state),
    );
  }


}