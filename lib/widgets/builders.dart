import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:nodebb/application/application.dart';
import 'package:nodebb/enums/enums.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/widgets/widgets.dart';
import 'package:nodebb/utils/utils.dart' as utils;

buildBottomDividerDecoration(BuildContext context) {
  return new BoxDecoration(
      border: new Border(bottom: new BorderSide(
        color: Theme.of(context).dividerColor
      ))
  );
}

buildCover(User user) {
  if(user == null || user.cover == null || user.cover.length == 0) {
    return new Image.asset('assets/images/flutter_cover.jpg',
      width: ui.window.physicalSize.width / ui.window.devicePixelRatio,
      height: 160.0,
      fit: BoxFit.cover,
      alignment: Alignment.center,
    );
  } else {
    return new Image.network(
      'http://${Application.host}${user.cover}',
      width: ui.window.physicalSize.width / ui.window.devicePixelRatio,
      height: 160.0,
      fit: BoxFit.cover,
      alignment: Alignment.topLeft,
    );
  }
}

buildAvatar(User user) {
  var avatar;
  if(user == null) {
    avatar = new CircleAvatar(
      backgroundImage: new AssetImage('assets/images/flutter_avatar.png'),
      backgroundColor: utils.parseColorFromStr('#ffffff'),
    );
  } else {
    avatar = new NodeBBAvatar(
        picture: user?.picture,
        iconText: user?.iconText,
        iconBgColor: user?.iconBgColor
    );
  }
  return new SizedBox(
      height: 42.0,
      child: new Stack(
        alignment: AlignmentDirectional.center,
        overflow: Overflow.visible,
        children: <Widget>[
          new Positioned(
            top: -42.0,
            width: 84.0,
            height: 84.0,
            child: avatar,
          )
        ],
      ));
}

buildTextColumn({title, content}) {
  return new Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      new Text(title, style: const TextStyle(fontSize: 18.0)),
      new Padding(padding: const EdgeInsets.only(top: 12.0)),
      new Text('$content', style:  const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),)
    ],
  );
}

buildUserInfo(User user) {
  if(user == null) {
    return new Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
      child: new Builder(builder: (BuildContext context) {
        return new MaterialButton(
          height: 44.0,
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          onPressed: () {
            Navigator.of(context).pushNamed('/login');
          },
          child: new Text('立即登录', style: const TextStyle(fontSize: 18.0),),
        );
      })
    );

  } else {
    return new Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: new Builder(builder: (BuildContext context) {
          return new Container(
            padding: const EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 12.0),
            decoration: buildBottomDividerDecoration(context),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                buildTextColumn(title: '声望', content: user.reputation),
                buildTextColumn(title: '粉丝', content: user.followerCount),
                buildTextColumn(title: '话题', content: user.topicCount)
              ],
            ),
          );
        })
    );
  }
}

buildPendingBody({RequestStatus status, bodyBuilder, onRetry}) {
  Widget body;
  switch (status) {
    case RequestStatus.SUCCESS:
      body = bodyBuilder();
      break;
    case RequestStatus.ERROR:
      body = new Builder(
        builder: (BuildContext context) {
          var children = <Widget>[new Text('出错了！')];
          if(onRetry != null) {
            children.add(new MaterialButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: onRetry,
              child: new Text('重试'),
            ));
          }
          return new Center(
            child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: children
          ));
        }
      );
      break;
    case RequestStatus.EMPTY:
      body = new Center(child: new Text('╮(๑•́ ₃•̀๑)╭没有内容'));
      break;
    default:
      body = new Center(child: new Text('加载中...'));
      break;
  }
  return body;
}