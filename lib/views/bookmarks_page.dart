import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/enums/enums.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/mutations/mutations.dart';
import 'package:nodebb/services/io_service.dart';
import 'package:nodebb/services/remote_service.dart';
import 'package:nodebb/views/base.dart';
import 'package:nodebb/widgets/builders.dart';
import 'package:nodebb/widgets/widgets.dart';

class BookmarksPage extends BaseReactivePage {
  BookmarksPage({Key key, Map routeParams}) : super(key: key, routeParams: routeParams);

  @override
  _BookmarksPageState createState() => new _BookmarksPageState();
}


class _BookmarksPageState extends BaseReactiveState<BookmarksPage> {

  ObservableList<Topic> topics = new ObservableList();

  List<Post> posts = [];

  bool initial = false;

  ReactiveProp<RequestStatus> status = new ReactiveProp();

  @override
  void initState() {
    super.initState();
    status.self = RequestStatus.PENDING;

  }

  _fetchContent() {
    status.self = RequestStatus.PENDING;
    RemoteService.getInstance().fetchBookmarks($store.state.activeUser.uid).then((List data) {
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
    }).catchError((_) {
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
      appBar: new AppBar(title: const Text("我的收藏")),
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
                  $store.commit(new AddRecentViewTopic(topics[index].tid));
                  Navigator.of(context).pushNamed('/topic/${posts[index].tid}');
                },
                onLongPress: (BuildContext context, TapDownDetails details) {
                  RenderBox box = context.findRenderObject();
                  //var topLeftPosition = box.localToGlobal(Offset.zero);
                  showMenu(
                    context: context,
                    position: new RelativeRect.fromLTRB(
                        details.globalPosition.dx,
                        details.globalPosition.dy,
                        box.size.width - details.globalPosition.dx,
                        0.0
                    ),
                    items: [
                      new PopupMenuItem<int>(
                        value: 0,
                        child: new Text('删除'),
                      ),
                    ]
                  ).then((val) {
                    if(val == 0) {
                      IOService.getInstance().unbookmark(
                        topicId: topics[index].tid,
                        postId: topics[index].mainPid
                      ).then((_) {
                        topics.removeAt(index);
                        if(topics.isEmpty) {
                          status.self = RequestStatus.EMPTY;
                        }
                        Scaffold.of(context).showSnackBar(new SnackBar(
                          content: new Text('删除成功！'),
                          backgroundColor: Colors.green,
                        ));
                      }).catchError((err) {
                        Scaffold.of(context).showSnackBar(new SnackBar(
                          content: new Text('删除失败，请重试！'),
                          backgroundColor: Colors.red,
                        ));
                      });
                    }
                  });
                },
              );
            },
          );
        }, onRetry: () {
          _fetchContent();
        })
    )
    );
  }

}
