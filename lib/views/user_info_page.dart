import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/actions/actions.dart';
import 'package:nodebb/enums/enums.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/services/io_service.dart';
import 'package:nodebb/services/remote_service.dart';
import 'package:nodebb/views/base.dart';
import 'package:nodebb/widgets/builders.dart';

class UserInfoPage extends BaseReactivePage {
  UserInfoPage({Key key, routeParams}) : super(key: key, routeParams: routeParams);

  @override
  _UserInfoPageState createState() => new _UserInfoPageState();
}

class _UserInfoPageState extends BaseReactiveState<UserInfoPage> {

  ReactiveProp<RequestStatus> status = new ReactiveProp();

  ReactiveProp<User> user = new ReactiveProp();

  @override
  void initState() {
    super.initState();
    this._fetchContent();
  }

  _fetchContent() {
    status.self = RequestStatus.PENDING;
    RemoteService.getInstance().fetchUserInfo(int.parse(widget.routeParams['uid'])).then((Map json) {
      try {
        user.self = new User.fromJSON(json);
        status.self = RequestStatus.SUCCESS;
      } catch(err) {
        status.self = RequestStatus.ERROR;
      }
    }).catchError((err) {
      status.self = RequestStatus.ERROR;
    });
  }

  _startChat(User user) async {
    var existsRoomId = await IOService.getInstance().hasPrivateChat(user.uid);
    if(existsRoomId == -1) {
      var newRoomId = await IOService.getInstance().newRoom(user.uid);
      await $store.dispatch(new FetchRecentChatAction());
      Navigator.of(context).pushNamed('/chat/$newRoomId');
    } else if(!$store.state.rooms.containsKey(existsRoomId)) {
      await $store.dispatch(new FetchRecentChatAction());
      Navigator.of(context).pushNamed('/chat/$existsRoomId');
    } else {
      Navigator.of(context).pushNamed('/chat/$existsRoomId');
    }
  }

  @override
  Widget render(BuildContext context) {
    String userName = ($store.state.shareStorage['user_info_page'] as User).userName;
    return new Scaffold(
      appBar: new AppBar(title: new Text("$userName")),
      body: buildPendingBody(status: status.self, bodyBuilder: () {
        return new Stack(
          children: <Widget>[
            new Column(
              children: <Widget>[
                buildCover(user.self),
                buildAvatar(user.self),
                buildUserInfo(user.self)
              ],
            ),
            new Positioned(
              bottom: 8.0,
              right: 16.0,
              left: 16.0,
              child: new MaterialButton(
                height: 48.0,
                color: user.self.uid == $store.state.activeUser?.uid ? Colors.grey : Colors.green,
                onPressed: () {
                  $checkLogin().then((_) {
                    if(user.self.uid == $store.state.activeUser?.uid) return;
                    _startChat(user.self);
                  });
                },
                child: new Text('打招呼', style: const TextStyle(color: Colors.white, fontSize: 18.0),),
              ),
            )
          ],
        );
      })
    );
  }

}