import 'package:flutter/material.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/views/base.dart';
import 'package:nodebb/widgets/widgets.dart';

class ChatPage extends BaseReactivePage {
  ChatPage({Key key}) : super(key: key);

  @override
  BaseReactiveState<ChatPage> createState() => new _RegisterPageState();
}

class _RegisterPageState extends BaseReactiveState<ChatPage> {

  ObservableList<Message> messages = new ObservableList<Message>();

  TextEditingController _textController =  new TextEditingController();

  _handleSubmit(String message) {
    if(message == null || message.length == 0) return;
    _textController.clear();
    messages.insert(0, new Message(
        content: message,
        type: MessageType.SEND,
        user: $store.state.activeUser,
        createdTime: new DateTime.now()
      )
    );
  }

  @override
  Widget render(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('聊天')),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: new ListView.builder(
              reverse: true,
              itemBuilder: (BuildContext context, int index) {
                $enterScope();
                if(index >= messages.length) {
                  $leaveScope();
                  return null;
                } else {
                  Widget w = new MessageWidget(messages[index]);
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
}
