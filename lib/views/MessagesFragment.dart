import 'package:flutter/material.dart';

class MessagesFragment extends StatefulWidget {
  MessagesFragment({Key key}): super(key: key);

  @override
  State createState() {
    return new _MessagesFragmentState();
  }
}

class _MessagesFragmentState extends State<MessagesFragment> {

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new Center(
            child: new Text('消息')
        )
    );
  }

}