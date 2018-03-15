import 'package:flutter/material.dart';
import 'package:nodebb/application/application.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/utils/utils.dart' as utils;

class NodeBBAvatar extends StatelessWidget {

  final String picture;

  final String iconText;

  final String iconBgColor;

  NodeBBAvatar({this.picture, this.iconText, this.iconBgColor});

  @override
  Widget build(BuildContext context) {
    return new CircleAvatar(
      child: !utils.isEmpty(picture) ? null : new Text(iconText),
      backgroundColor: utils.parseColorFromStr(iconBgColor),
      backgroundImage: utils.isEmpty(picture) ? null : new NetworkImage('http://${Application.host}$picture'),
    );
  }

}

class MessageWidget extends StatelessWidget {

  Message message;

  MessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    if(message.type == MessageType.RECEIVE) {
      return new Container(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, right: 24.0, left: 12.0),
        child: new Row(
          children: <Widget>[
            new NodeBBAvatar(
              picture: message.user.picture,
              iconBgColor: message.user.iconBgColor,
              iconText: message.user.iconText,
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
                          message.content,
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
          padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, right: 12.0, left: 24.0),
          child: new Row(
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
                            message.content,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      )
                    ),
                  ]
                )
              ),
              new NodeBBAvatar(
                picture: message.user.picture,
                iconBgColor: message.user.iconBgColor,
                iconText: message.user.iconText,
              )
            ],
          )
      );
    }
  }
}