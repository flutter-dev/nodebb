import 'package:flutter/material.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/actions/actions.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/views/base.dart';
import 'package:nodebb/widgets/widgets.dart';
import 'package:nodebb/mutations/mutations.dart';

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

  bool isLoadingMore = false;

  bool isCannotLoadMore = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget render(BuildContext context) {
    return new RefreshIndicator(
      child: new ListView.builder(
        itemCount: $store.state.topics.values.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if(isCannotLoadMore && !isLoadingMore && $store.state.topics.values.length - index <= 10) {
            isLoadingMore = true;
            int oldListLength = $store.state.topics.values.length;
            $store.dispatch(new FetchTopicsAction(start: oldListLength, count: 19, clearBefore: false)).then((_) {
                if($store.state.topics.values.length - oldListLength < 20) {
                  isCannotLoadMore = false;
                }
            }).whenComplete(() {
              isLoadingMore = false;
              setState(() {});
            });
          }
          if(index == $store.state.topics.values.length) {
            if(isCannotLoadMore) {
              return new Container(
                height: 64.0,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text('加载中...')
                  ],
                )
              );
            } else {
              return new Container(
                  height: 64.0,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Text('# end #')
                    ],
                  )
              );
            }
          } else if(index > $store.state.topics.values.length) {
            return null;
          }
          Topic topic = $store.state.topics.values.toList()[index];
          User user = topic.user;
          return new ListTile(
            key: new ValueKey<int>(topic.tid),
            leading: new SizedBox(
              width: 56.0,
              height: 56.0,
              child: new NodeBBAvatar(picture: user?.picture, iconText: user.iconText, iconBgColor: user.iconBgColor)
            ),
            title: new Container(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: new Text(topic.title),
            ),
            subtitle: new Text('${topic.viewCount} 浏览 · ${topic.postCount - 1} 回复'),
            onTap: () {
              $store.commit(new AddRecentViewTopic(topic.tid));
              Navigator.of(context).pushNamed('/topic/${topic.tid}');
            },
          );
        },
      ),
      onRefresh: () async {
        await $store.dispatch(new FetchTopicsAction(start: 0, count: 20, clearBefore: true));
        //$store.state.notification.newTopic
        //$store.commit(new UpdateNotificationMutation(newTopic: false));
      }
    );
  }

}