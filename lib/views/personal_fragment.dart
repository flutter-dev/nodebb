import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:nodebb/application/application.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/views/base.dart';
import 'package:nodebb/widgets/widgets.dart';
import 'package:nodebb/utils/utils.dart' as utils;

class PersonalFragment extends BaseReactiveWidget {
  PersonalFragment({Key key}) : super(key: key);

  @override
  BaseReactiveState<PersonalFragment> createState() {
    return new _PersonalFragmentState();
  }
}

class _PersonalFragmentState extends BaseReactiveState<PersonalFragment> {

  _buildCover() {
    if($store.state.activeUser == null) {
      return new Image.asset('assets/images/flutter_cover.jpg',
        width: ui.window.physicalSize.width / ui.window.devicePixelRatio,
        height: 160.0,
        fit: BoxFit.cover,
        alignment: Alignment.center,
      );
    } else {
       return new Image.network(
        'http://${Application.host}${$store.state.activeUser.cover}',
        width: ui.window.physicalSize.width / ui.window.devicePixelRatio,
        height: 160.0,
        fit: BoxFit.cover,
        alignment: Alignment.topLeft,
      );
    }
  }
  
  _buildAvatar() {
    User user = $store.state.activeUser;
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

  _buildTextColumn({title, content}) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Text(title, style: const TextStyle(fontSize: 18.0)),
        new Text('$content', style:  const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),)
      ],
    );
  }

  _buildUserInfo() {
    User user = $store.state.activeUser;
    if(user == null) {
      return new Center(
        child: new Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: new MaterialButton(
            height: 44.0,
            minWidth: 316.0,
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushNamed('/login');
            },
            child: new Text('立即登录', style: const TextStyle(fontSize: 18.0),),
          ),
        )
      );
    } else {
      return new Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: new Container(
            padding: const EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 12.0),
            decoration: _buildBottomDivider(),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildTextColumn(title: '声望', content: user.reputation),
                _buildTextColumn(title: '粉丝', content: user.followerCount),
                _buildTextColumn(title: '话题', content: user.topicCount)
              ],
            ),
          )
      );
    }
  }

  _buildBottomDivider() {
    return new BoxDecoration(
      border: new Border(bottom: new BorderSide(
          color: utils.parseColorFromStr('#ededed')
      ))
    );
  }

  _buildSelectItem({title, icon, divider = true, onTap}) {
    return new InkWell(
      onTap: onTap,
      child: new Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: new Container(
            decoration: divider ? _buildBottomDivider() : null,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                    child: new Text(title, style: const TextStyle(fontSize: 16.0),)
                ),
                new Icon(icon)
              ],
            ),
          )
      )
    );
  }

  _buildLogoutButton() {
    return new Center(
        child: new Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: new MaterialButton(
            height: 44.0,
            minWidth: 316.0,
            color: Colors.red,
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushNamed('/login');
            },
            child: new Text('登出', style: const TextStyle(fontSize: 18.0),),
          ),
        )
    );
  }

  @override
  Widget render(BuildContext context) {
    return new ListView(
      children: <Widget>[
        _buildCover(),
        _buildAvatar(),
        _buildUserInfo(),
        _buildSelectItem(title: '我的收藏', icon: Icons.star_border),
        _buildSelectItem(title: '最近浏览', icon: Icons.remove_red_eye),
        _buildSelectItem(title: '设置', icon: Icons.settings),
        _buildSelectItem(title: '关于', icon: Icons.group),
        _buildLogoutButton()
      ],
    );
  }
}
