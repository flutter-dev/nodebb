import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/mutations/mutations.dart';
import 'package:nodebb/services/io_service.dart';
import 'package:nodebb/views/base.dart';
import 'package:nodebb/widgets/widgets.dart';
import 'package:nodebb/errors/errors.dart';
import 'package:nodebb/utils/utils.dart' as utils;

class ChatPage extends BaseReactivePage {
  ChatPage({Key key, routeParams}) : super(key: key, routeParams: routeParams);

  @override
  BaseReactiveState<ChatPage> createState() => new _RegisterPageState();
}

class _RegisterPageState extends BaseReactiveState<ChatPage> {

  Room room;

  StreamSubscription chatSub;

  TextEditingController _textController =  new TextEditingController();

  _handleSubmit(String content) {
    if(content == null || content.length == 0) return;
    _textController.clear();
    Message msg = new Message(
      content: content,
      type: MessageType.SEND_PENDING,
      user: $store.state.activeUser,
      timestamp: new DateTime.now()
    );
    IOService.getInstance().sendMessage(roomId: room.roomId, content: content).then((Message message) {
      msg.id = message.id;
      msg.type = MessageType.SEND;
    }).catchError((err) {
      if(err is NodeBBNoUserInRoomException) {
        Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('房间没有用户！'), backgroundColor: Colors.red,));
      } else {
        Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('未知错误，请重试！'), backgroundColor: Colors.red,));
      }
    });
    room.messages.insert(0, msg);
    //FocusScope.of(context).requestFocus(new FocusNode()); //收起键盘
    //SystemChannels.textInput.invokeMethod('TextInput.hide');
  }


  @override
  void initState() {
    super.initState();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    room = $store.state.rooms[int.parse(widget.routeParams['roomId'])];
    IOService.getInstance().loadRoom(roomId: room.roomId, uid: $store.state.activeUser.uid).then((List<Message> messages) {
      messages = messages.map((Message msg) {
        if(msg.user.uid == $store.state.activeUser.uid) {
          msg.type = MessageType.SEND;
        }
        return msg;
      }).toList().reversed.toList();
      $store.commit(new ClearMessagesFromRoomMutation(room.roomId));
      $store.commit(new AddMessagesToRoomMutation(room.roomId, messages));
      IOService.getInstance().markRead(room.roomId);
    });
    chatSub?.cancel();
    chatSub = IOService.getInstance().eventStream.listen(null)..onData((NodeBBEvent event) {
      if(event.type == NodeBBEventType.RECEIVE_CHATS) {
        Map data = event.data;
        if(utils.convertToInteger(data['roomId']) == room.roomId
         && data['fromUid'] != $store.state.activeUser.uid) {
          room.messages.insert(0, new Message.fromJSON(data['message']));
          event.ack();
        }
        if(utils.convertToInteger(data['roomId']) == room.roomId) {
          IOService.getInstance().markRead(room.roomId);
        }
      }
    });
  }

  @override
  Widget render(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(utils.isEmpty(room.roomName) ? room.ownerName : room.roomName)),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: new ListView.builder(
              reverse: true,
              itemBuilder: (BuildContext context, int index) {
                $enterScope();
                if(index >= room.messages.length) {
                  $leaveScope();
                  return null;
                } else {
                  Widget w = new MessageWidget(room.messages[index]);
                  $leaveScope();
                  return w;
                }
              }
            )
          ),
          new SizedBox(
            height: 54.0,
            child: new Column(
              children: <Widget>[
                new Divider(height: 0.0,),
                new Expanded(
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: new TextField(
                            controller: _textController,
                            maxLines: 1,
                            style: new TextStyle(fontSize: 18.0, color: Theme.of(context).textTheme.body1.color),
                            decoration: const InputDecoration(contentPadding: const EdgeInsets.only(bottom: 6.0, top: 6.0)),
                            onSubmitted: _handleSubmit,
                          ),
                        ),
                      ),
                      new InkWell(
                        onTap: () {
                          _handleSubmit(_textController.text);
                        },
                        borderRadius: const BorderRadius.all(const Radius.circular(54.0)),
                        child: new SizedBox(
                          width: 54.0,
                          height: 54.0,
                          child: new Icon(Icons.send, size: 32.0,),
                        )
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }



  @override
  void dispose() {
    chatSub?.cancel();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.dispose();
    //FocusScope.of(context).requestFocus(new FocusNode());
  }


}
