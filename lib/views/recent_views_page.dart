import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/enums/enums.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/mutations/mutations.dart';
import 'package:nodebb/services/remote_service.dart';
import 'package:nodebb/views/base.dart';
import 'package:nodebb/widgets/builders.dart';
import 'package:nodebb/widgets/widgets.dart';

class RecentViewsPage extends BaseReactivePage {
  RecentViewsPage({Key key, routeParams}) : super(key: key, routeParams: routeParams);

  @override
  _RegisterViewPageState createState() => new _RegisterViewPageState();
}

class _RegisterViewPageState extends BaseReactiveState<RecentViewsPage> {

  List<Topic> topics = [];

  List<Post> posts = [];

  bool initial = false;

  ReactiveProp<RequestStatus> status = new ReactiveProp();

  _fetchContent() {
    status.self = RequestStatus.PENDING;
    RemoteService.getInstance().fetchTopicsCollection($store.state.recentViews.reversed.toList()).then((List data) {
      data = data ?? [];
      if(data.isNotEmpty) {
        List<Map> topicsFromData = data.cast<Map>();
        for (var data in topicsFromData) {
          topics.add(new Topic.fromJSON(data));
          List ps = data['posts'];
          posts.add(new Post.fromJSON(ps.cast<Map>()[0]));
        }
        status.self = RequestStatus.SUCCESS;
      } else {
        status.self = RequestStatus.EMPTY;
      }
    }).catchError((err) {
      status.self = RequestStatus.ERROR;
    });
  }

  @override
  Widget render(BuildContext context) {
    if(!initial) {
      _fetchContent();
      initial = true;
    }
    return new Scaffold(
      appBar: new AppBar(title: const Text('最近浏览'),),
      body: new Container(
        child: buildPendingBody(status: status.self, bodyBuilder: () {
          return new ListView.builder(
            //padding: const EdgeInsets.all(16.0),
            itemCount: topics.length,
            itemBuilder: (BuildContext context, int index) {
              return new TopicsSummaryItem(
                topic: topics[index],
                post: posts[index],
                onTap: () {
                  //$store.commit(new AddRecentViewTopic(topics[index].tid));
                  Navigator.of(context).pushNamed('/topic/${posts[index].tid}');
                },
              );
            },
          );
        }, onRetry: () {
          _fetchContent();
        }),
      ),
    );
  }

}