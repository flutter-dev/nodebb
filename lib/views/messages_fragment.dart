import 'package:flutter/material.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/mutations/mutations.dart';
import 'package:nodebb/services/io_service.dart';
import 'package:nodebb/views/base.dart';
import 'package:nodebb/widgets/builders.dart';
import 'package:nodebb/widgets/widgets.dart';

class MessagesFragment extends BaseReactiveWidget {
  MessagesFragment({Key key}): super(key: key);

  @override
  BaseReactiveState<MessagesFragment> createState() {
    return new _MessagesFragmentState();
  }
}

class _MessagesFragmentState extends BaseReactiveState<MessagesFragment> {

  Widget _buildSystemItem({icon, iconColor, title, onTap}) {
    return new InkWell(
      onTap: onTap,
      child: new SizedBox(
        height: 64.0,
        child: new Container(
          padding: const EdgeInsets.only(left: 8.0, right: 12.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Icon(icon, size: 36.0, color: iconColor,),
              new Padding(padding: const EdgeInsets.only(right: 8.0)),
              new Expanded(
                child: new Container(
                  decoration: buildBottomDividerDecoration(context),
                  padding: const EdgeInsets.only(left: 6.0),
                  child: new Align(
                    alignment: Alignment.centerLeft,
                    child: new Text(title, style: const TextStyle(fontSize: 16.0),),
                  )
                )
              )
            ],
          )
        )
      )
    );
  }

  Widget _buildRoomItem({Room room, onTap, onLongPress}) {
    User user;
    if(room.users.isNotEmpty) {
      user = room.users[0];
    } else {
      user = $store.state.activeUser;
    }
    String content = room.teaser?.content ?? '';
    TapDownDetails _details;
    return new Builder(
      builder: (BuildContext context) {
        return  new InkWell(
          onTap: onTap,
          onLongPress: () {
            onLongPress(context, _details);
          },
          onTapDown: (TapDownDetails details) {
            _details = details;
          },
          child: new SizedBox(
            height: 64.0,
            child: new Container(
              padding: const EdgeInsets.only(left: 8.0, right: 12.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new SizedBox(
                      width: 42.0,
                      height: 42.0,
                      child: new NodeBBAvatar(
                        picture: user.picture,
                        iconText: user.iconText,
                        iconBgColor: user.iconBgColor,
                        marked: room.unread,
                      )
                  ),
                  new Padding(padding: const EdgeInsets.only(right: 4.0)),
                  new Expanded(
                      child: new Container(
                          decoration: buildBottomDividerDecoration(context),
                          padding: const EdgeInsets.only(left: 6.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text(user.userName, style: const TextStyle(fontSize: 16.0),),
                              new Padding(padding: const EdgeInsets.only(top: 4.0)),
                              new Text(content, maxLines: 1, overflow:TextOverflow.ellipsis, style: const TextStyle(fontSize: 14.0, color: Colors.grey))
                            ],
                          )
                      )
                  )
                ],
              )
            )
          )
        );
      },
    );

  }

  @override
  Widget render(BuildContext context) {
    List<Widget> contents = new List();
    contents.addAll([
      _buildSystemItem(
        icon: Icons.search,
        title: '查找用户',
        iconColor: Theme.of(context).primaryColor,
        onTap: () {
          Navigator.of(context).pushNamed('/search_user');
        }
      ),
//      _buildSystemItem(
//        icon: Icons.rss_feed,
//        title: '系统通知',
//        iconColor: Theme.of(context).primaryColor
//      ),
//      _buildSystemItem(
//        icon: Icons.send,
//        title: '管理员',
//        iconColor: Theme.of(context).primaryColor,
//        onTap: () {
//          Navigator.of(context).pushNamed('/chat/0');
//        }
//      )
    ]);
    $store.state.rooms.values.forEach((Room room) {
      contents.add(_buildRoomItem(room: room,
        onTap: () {
          for(User user in room.users) {
            if(user.uid != $store.state.activeUser?.uid) {
              $store.commit(new AddUsersMutation([user]));
            }
          }
          Navigator.of(context).pushNamed('/chat/${room.roomId}');
        },
        onLongPress: (BuildContext context, TapDownDetails details) {
          RenderBox box = context.findRenderObject();
          var topLeftPosition = box.localToGlobal(Offset.zero);
          showMenu(
            context: context,
            position: new RelativeRect.fromLTRB(details.globalPosition.dx, topLeftPosition.dy, box.size.width - details.globalPosition.dx, 0.0),
            items: [
              new PopupMenuItem<int>(
                value: 0,
                child: new Text('标记已读'),
              ),
              new PopupMenuItem<int>(
                value: 1,
                child: new Text('删除'),
              ),
            ]
          ).then((val) {
            if(val == 1) {
              IOService.getInstance().markRead(room.roomId);
              IOService.getInstance().leaveRoom(room.roomId).then((_) {
                $store.commit(new DeleteRoomMutation(room.roomId));
              }).catchError((err) {
                Scaffold.of(context).showSnackBar(new SnackBar(
                  content: new Text('删除失败，请重试！'),
                  backgroundColor: Colors.red,
                ));
              });
            } else if(val == 0) {
              IOService.getInstance().markRead(room.roomId);
            }
          });
        }
      ));
    });
    return new ListView(
      children: contents,
    );
  }

}