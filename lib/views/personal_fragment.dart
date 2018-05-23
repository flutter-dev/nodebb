import 'package:flutter/material.dart';
import 'package:nodebb/actions/actions.dart';
import 'package:nodebb/views/base.dart';
import 'package:nodebb/widgets/builders.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalFragment extends BaseReactiveWidget {
  PersonalFragment({Key key}) : super(key: key);

  @override
  BaseReactiveState<PersonalFragment> createState() {
    return new _PersonalFragmentState();
  }
}

class _PersonalFragmentState extends BaseReactiveState<PersonalFragment> {

  _resetUser() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('username', '');
      prefs.setString('password', '');
    });
  }

  _buildSelectItem({title, icon, divider = true, onTap}) {
    return new InkWell(
      onTap: onTap,
      child: new Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: new Container(
            decoration: divider ? buildBottomDividerDecoration(context) : null,
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
    if($store.state.activeUser != null) {
      return new Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: new MaterialButton(
          height: 44.0,
          color: Colors.red,
          textColor: Colors.white,
          onPressed: () {
            $confirm('确认要退出？', onConfirm: () {
              $store.dispatch(new LogoutAction()).then((_) {
                _resetUser();
              });
            });
          },
          child: new Text('退出', style: const TextStyle(fontSize: 18.0),),
        ),
      );
    } else {
      return new Container();
    }
  }

  @override
  Widget render(BuildContext context) {
    return new ListView(
      children: <Widget>[
        buildCover($store.state.activeUser),
        buildAvatar($store.state.activeUser),
        buildUserInfo($store.state.activeUser),
        _buildSelectItem(title: '我的收藏', icon: Icons.star, onTap: () {
          $checkLogin().then((_) {
            Navigator.of(context).pushNamed('/bookmarks');
          });
        }),
        _buildSelectItem(title: '最近浏览', icon: Icons.remove_red_eye, onTap: () {
          $checkLogin().then((_) {
            Navigator.of(context).pushNamed('/recent_views');
          });
        }),
//        _buildSelectItem(title: '设置', icon: Icons.settings),
        _buildSelectItem(title: '关于', icon: Icons.group, onTap: () {
          showAboutDialog(
            context: context,
            applicationName: 'Flutter中文论坛客户端',
            applicationVersion: '0.0.1',
            applicationIcon: new SizedBox(
              width: 48.0,
              height: 48.0,
              child: new Image.asset('assets/images/flutter_avatar.png')
            )
          );
        }),
        _buildLogoutButton()
      ],
    );
  }
}
