import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nodebb/application/application.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/utils/utils.dart' as utils;
import 'package:nodebb/views/base.dart';
import 'package:nodebb/widgets/builders.dart';

class NodeBBAvatar extends StatelessWidget {

  final String picture;

  final String iconText;

  final String iconBgColor;

  final bool marked;

  NodeBBAvatar({this.picture, this.iconText, this.iconBgColor, this.marked = false});

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    children.add(
      new FittedBox(
        fit: BoxFit.contain,
        child: new CircleAvatar(
          child: !utils.isEmpty(picture) ? null : new Text(iconText),
          backgroundColor: utils.parseColorFromStr(iconBgColor),
          foregroundColor: Colors.white,
          backgroundImage: utils.isEmpty(picture) ? null : new NetworkImage('http://${Application.host}$picture'),
        )
      )
    );
    if(marked) {
      children.add(new Positioned(
        right: 0.0,
        top: 0.0,
        child: marked ? new Container(
          width: 8.0,
          height: 8.0,
          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
        ) : null,
      ));
    }
    return new Stack(
      fit: StackFit.expand,
      alignment: AlignmentDirectional.center,
      overflow: Overflow.visible,
      children: children,
    );
  }

}

class MessageWidget extends BaseReactiveWidget {

  final Message message;

  MessageWidget(this.message);

  @override
  BaseReactiveState<MessageWidget> createState() {
    return new _MessageWidgetState();
  }


}

class _MessageWidgetState extends BaseReactiveState<MessageWidget> {

  @override
  Widget render(BuildContext context) {
    if(widget.message.type == MessageType.RECEIVE) {
      return new Container(
          padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, right: 64.0, left: 12.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new SizedBox(
                width: 40.0,
                height: 40.0,
                child: new NodeBBAvatar(
                  picture: widget.message.user.picture,
                  iconBgColor: widget.message.user.iconBgColor,
                  iconText: widget.message.user.iconText,
                )
              ),
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: new ClipRRect(
                        borderRadius: const BorderRadius.all(const Radius.circular(6.0)),
                        child: new Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: const BoxDecoration(
                              color: Colors.white70
                          ),
                          child: new Text(
                            widget.message.content.replaceAll(RegExp(r'\n$'), ''),
                            style: const TextStyle(height: 1.4),
                          ),
                        ),
                      )
                    ),
                  ]
                )
              )
            ],
          )
      );
    } else {
      return new Container(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, right: 12.0, left: 64.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  new Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: new ClipRRect(
                        borderRadius: const BorderRadius.all(const Radius.circular(6.0)),
                        child: new Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: const BoxDecoration(
                              color: Colors.lightGreen
                          ),
                          child: new Text(
                            widget.message.type == MessageType.SEND_PENDING ?
                              '[待确认]' +  widget.message.content.replaceAll(RegExp(r'\n$'), '') :
                              widget.message.content.replaceAll(RegExp(r'\n$'), ''),
                            style: const TextStyle(height: 1.4),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      )
                  ),
                ]
              )
            ),
            new SizedBox(
              width: 40.0,
              height: 40.0,
              child: new NodeBBAvatar(
                picture: widget.message.user.picture,
                iconBgColor: widget.message.user.iconBgColor,
                iconText: widget.message.user.iconText,
              )
            )
          ],
        )
      );
    }
  }
}

class Markdown extends MarkdownWidget {

  final List<Widget> additionalChildren;

  const Markdown({
    Key key,
    String data,
    MarkdownStyleSheet styleSheet,
    SyntaxHighlighter syntaxHighlighter,
    MarkdownTapLinkCallback onTapLink,
    Directory imageDirectory,
    this.additionalChildren,
    this.padding: const EdgeInsets.all(16.0),
  }) : super(
    key: key,
    data: data,
    styleSheet: styleSheet,
    syntaxHighlighter: syntaxHighlighter,
    onTapLink: onTapLink,
    imageDirectory: imageDirectory,
  );

  /// The amount of space by which to inset the children.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context, List<Widget> children) {
    return new ListView(padding: padding, children: <Widget>[]..addAll(children)..addAll(additionalChildren));
  }
}

class TopicsSummaryItem extends StatelessWidget {

  final Topic topic;

  final Post post;

  final onTap;

  final onLongPress;

  TapDownDetails _details;

  TopicsSummaryItem({this.topic, this.post, this.onTap, this.onLongPress});

  _getSummary(content) {
    var lines = post.content.replaceAll('\r\n', '\n').split('\n');
    var content;
    if(lines.length > 2) {
      content = lines.sublist(0, 2).join('\n');
    } else {
      content = lines.join('');
    }
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: this.onTap,
      onTapDown: (TapDownDetails details) {
        _details = details;
      },
      onLongPress: () {
        this.onLongPress(context, _details);
      },
      child: new Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: new Container(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text('${topic.title}', overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 20.0)),
              new Padding(padding: const EdgeInsets.only(top: 12.0)),
              new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    child: new Text('${post.votes}',
                      style: new TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                      )
                    ),
                    alignment: Alignment.center,
                    width: 48.0,
                    height: 48.0,
                    decoration: new BoxDecoration(color: Colors.blue, borderRadius: new BorderRadius.circular(24.0)),
                    margin: const EdgeInsets.only(right: 8.0),
                  ),
                  new Flexible(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text('${topic.user.userName}', overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.grey),),
                        new Padding(padding: const EdgeInsets.only(top: 8.0)),
                        new MarkdownBody(data: _getSummary(post.content))
                      ],
                    )
                  )
                ],
              ),
            ],
          ),
          decoration: buildBottomDividerDecoration(context),
        )

      )
    );
  }
}

class CustomScrollBehavior extends ScrollBehavior {

  @override
  Widget buildViewportChrome(BuildContext context, Widget child,
      AxisDirection axisDirection) {
    return child;
  }
}

