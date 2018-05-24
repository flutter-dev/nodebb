import 'package:flutter/material.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/actions/actions.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/views/base.dart';
import 'package:nodebb/widgets/widgets.dart';
import 'package:nodebb/mutations/mutations.dart';

class TopicsFragment extends StatefulWidget {
  TopicsFragment({Key key}) : super(key: key);

  @override
  State createState() {
    return new _TopicsFragmentState();
  }
}

class _TopicsFragmentState extends State<TopicsFragment> {
  @override
  Widget build(BuildContext context) {
    return new Container(child: new TopicList());
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
            if (isCannotLoadMore &&
                !isLoadingMore &&
                $store.state.topics.values.length - index <= 10) {
              isLoadingMore = true;
              int oldListLength = $store.state.topics.values.length;
              $store
                  .dispatch(new FetchTopicsAction(
                      start: oldListLength, count: 19, clearBefore: false))
                  .then((_) {
                if ($store.state.topics.values.length - oldListLength < 20) {
                  isCannotLoadMore = false;
                }
              }).whenComplete(() {
                isLoadingMore = false;
                setState(() {});
              });
            }
            if (index == $store.state.topics.values.length) {
              if (isCannotLoadMore) {
                return new Container(
                    height: 64.0,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[new Text('加载中...')],
                    ));
              } else {
                return new Container(
                    height: 64.0,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[new Text('# end #')],
                    ));
              }
            } else if (index > $store.state.topics.values.length) {
              return null;
            }
            Topic topic = $store.state.topics.values.toList()[index];
            User user = topic.user;
            return getListItem(user, topic, context);
          },
        ),
        onRefresh: () async {
          await $store.dispatch(
              new FetchTopicsAction(start: 0, count: 20, clearBefore: true));
          //$store.state.notification.newTopic
          //$store.commit(new UpdateNotificationMutation(newTopic: false));
        });
  }

  Widget getListItem(User user, Topic topic, BuildContext context) {
    return new Card(
        shape: new RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(0.0)),
        ),
        margin: new EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
        child: new InkWell(
          child: new Padding(
            padding: new EdgeInsets.all(10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new SizedBox(
                  width: 56.0,
                  height: 56.0,
                  child: new NodeBBAvatar(
                      picture: user?.picture,
                      iconText: user.iconText,
                      iconBgColor: user.iconBgColor),
                ),
                new Expanded(
                  child: new Padding(
                    padding: new EdgeInsets.only(left: 10.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Padding(
                          padding: new EdgeInsets.only(bottom: 5.0),
                          child: new Row(
                            children: <Widget>[
                              new Text(user.userName,
                                  style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                        new Text(
                          topic.title,
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(top: 5.0),
                          child: new Text(
                            getTopicPostTimeDesc(topic.timestamp),
                            style: new TextStyle(
                                fontSize: 12.0, color: Colors.blue.shade500),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamed('/topic/${topic.tid}');
          },
        ));
  }

  String getTopicPostTimeDesc(DateTime time) {
    var now = new DateTime.now();
    if (now.year > time.year) {
      return "发布于 ${now.year-time.year} 年前";
    }
    if (now.month > time.month) {
      return "发布于 ${now.month-time.month} 月前";
    }
    if (now.day > time.day) {
      return "发布于 ${now.day-time.day} 天前";
    }
    if (now.hour > time.hour) {
      return "发布于 ${now.hour-time.hour} 小时前";
    }
    if (now.minute > time.minute) {
      return "发布于 ${now.minute-time.minute} 分钟前";
    }
    if (now.second > time.second) {
      return "发布于 ${now.second-time.second} 秒前";
    }
  }
}
