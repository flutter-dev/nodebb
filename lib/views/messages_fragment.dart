import 'package:flutter/material.dart';
import 'package:nodebb/views/base.dart';
import 'package:nodebb/widgets/builders.dart';

class MessagesFragment extends BaseReactiveWidget {
  MessagesFragment({Key key}): super(key: key);

  @override
  BaseReactiveState<MessagesFragment> createState() {
    return new _MessagesFragmentState();
  }
}

class _MessagesFragmentState extends BaseReactiveState<MessagesFragment> {

  _buildSystemItem({icon, iconColor, title, onTap}) {
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

  @override
  Widget render(BuildContext context) {
    return new ListView(
      children: <Widget>[
        _buildSystemItem(
          icon: Icons.rss_feed,
          title: '系统通知',
          iconColor: Theme.of(context).primaryColor
        ),
        _buildSystemItem(
          icon: Icons.send,
          title: '管理员',
          iconColor: Theme.of(context).primaryColor,
          onTap: () {
            Navigator.of(context).pushNamed('/chat/0');
          }
        )
      ],
    );
  }

}