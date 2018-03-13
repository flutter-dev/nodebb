import 'package:flutter/material.dart';
import 'package:nodebb/application/application.dart';
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