import 'package:flutter/material.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/actions/actions.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/views/base.dart';
import 'package:nodebb/widgets/widgets.dart';

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
    return new RefreshIndicator(
        child: new ListView.builder(
          itemCount: $store.state.topics.values.length,
          itemBuilder: (BuildContext context, int index) {
            if(index >= $store.state.topics.values.length) return null;
            Topic topic = $store.state.topics.values.toList()[index];
            User user = topic.user;
            return new ListTile(
              key: new ValueKey<int>(topic.tid),
              leading: new SizedBox(
                width: 40.0,
                height: 40.0,
                child: new NodeBBAvatar(picture: user?.picture, iconText: user.iconText, iconBgColor: user.iconBgColor)
              ),
              title: new Text(topic.title),
              subtitle: new Text('${topic.viewCount} 浏览 · ${topic.postCount - 1} 回复'),
              onTap: () {
                Navigator.of(context).pushNamed('/topic/${topic.tid}');
              },
            );
          },
        ),
        onRefresh: () {
          return $store.dispatch(new FetchTopicsAction());
        }
    );
  }

}