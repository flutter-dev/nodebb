import 'package:flutter/material.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/application/application.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/views/base.dart';
import 'package:nodebb/utils/utils.dart' as utils;

class TopicsFragment extends StatefulWidget {
  TopicsFragment({Key key}): super(key: key);

  @override
  State createState() {
    return new _TopicsFragmentState();
  }
}

class _TopicsFragmentState extends State<TopicsFragment> {

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new TopicList()
    );
  }

}

class TopicList extends BaseReactiveWidget {

  @override
  BaseReactiveState<ReactiveWidget> createState() {
    return new _TopicListState();
  }

}

class _TopicListState extends BaseReactiveState<TopicList> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget render(BuildContext context) {
    var listTiles = <ListTile>[];
    $store.state.topics.values.forEach((topic) {
      User user = $store.state.users[topic.uid];
      listTiles.add(new ListTile(
        key: new ValueKey<int>(topic.tid),
        leading: new CircleAvatar(
          child: !utils.isEmpty(user?.picture) ? null : new Text('${user.iconText}'),
          backgroundColor: utils.parseColorFromStr(user?.iconBgColor),
          backgroundImage: utils.isEmpty(user?.picture) ? null : new NetworkImage('http://${Application.host}${user?.picture}'),
        ),
        title: new Text(topic.title),
        subtitle: new Text('${topic.viewCount} 浏览 · ${topic.postCount - 1} 回复'),
        onTap: () {
          Navigator.of(context).pushNamed('/topic/${topic.tid}');
        },
      ));
    });
    return new ListView(
      children: listTiles
    );
  }

}