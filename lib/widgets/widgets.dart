import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nodebb/application/application.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/utils/utils.dart' as utils;
import 'package:nodebb/views/base.dart';

class NodeBBAvatar extends StatelessWidget {

  final String picture;

  final String iconText;

  final String iconBgColor;

  final bool marked;

  NodeBBAvatar({this.picture, this.iconText, this.iconBgColor, this.marked = false});

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    children.add(new CircleAvatar(
      child: !utils.isEmpty(picture) ? null : new Text(iconText),
      backgroundColor: utils.parseColorFromStr(iconBgColor),
      backgroundImage: utils.isEmpty(picture) ? null : new NetworkImage('http://${Application.host}$picture'),
    ));
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
                            widget.message.content,
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
                            widget.message.type == MessageType.SEND_PENDING ? '[待确认]' +  widget.message.content : widget.message.content,
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

