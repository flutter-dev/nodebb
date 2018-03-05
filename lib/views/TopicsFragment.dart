import 'package:flutter/material.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';
import 'package:nodebb/application/application.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/actions/actions.dart';
import 'package:built_collection/built_collection.dart';
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

class TopicList extends StoreConnector<AppState, AppActions, BuiltMap<String, Object>> {

  @override
  BuiltMap<String, Object> connect(AppState state) {
    List<Topic> listTopics = state.topics.allIds.map((id) {
      return state.topics.entities[id];
    }).toList();
    BuiltMap<String, Object> localState = new BuiltMap<String, Object>.build((b) {
      b.putIfAbsent('topics', ()=> new BuiltList<Topic>(listTopics));
      b.putIfAbsent('userEntities', ()=> state.users.entities);
    });
    return localState;
  }

  @override
  Widget build(BuildContext context, BuiltMap<String, Object> localState, AppActions actions) {
    var listTiles = <ListTile>[];
    BuiltList<Topic> topics = localState['topics'] as BuiltList<Topic>;
    BuiltMap<int, User> userEntities = localState['userEntities'] as BuiltMap<int, User>;
    topics?.forEach((topic) {
      User user = userEntities[topic.uid];
      listTiles.add(new ListTile(
        key: new ValueKey<int>(topic.tid),
        leading: new CircleAvatar(
          child: !utils.isEmpty(user?.picture) ? null : new Text('${userEntities[topic.uid].iconText}'),
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