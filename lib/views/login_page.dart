import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:nodebb/actions/actions.dart';
import 'package:nodebb/errors/errors.dart';
import 'package:nodebb/views/base.dart';

class LoginPage extends BaseReactivePage {
  LoginPage({Key key, routeParams}) : super(key: key, routeParams: routeParams);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends BaseReactiveState<LoginPage> {

  String username;

  String password;

  _doLogin(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    try {
      await $store.dispatch(new LoginAction(username, password));
    } on NodeBBLoginFailException {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text('登录失败，请检查用户名和密码是否正确')
      ));
    } catch(err) {

    }
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text('登录成功！ ${$store.state.activeUser.userName} 欢迎回来'),
      backgroundColor: Colors.green,
    ));
    new Timer(const Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget render(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text('登录')
      ),
      body: new Form(
        autovalidate: false,
        child: new ListView( //只有ListView才可以在键盘弹出的情况下，内容可以滚动，Column是不行的
          padding: const EdgeInsets.fromLTRB(24.0, 96.0, 24.0, 0.0),
          children: [
            new TextFormField(
              style: new TextStyle(fontSize: 18.0, color: Theme.of(context).textTheme.body1.color),
              decoration: new InputDecoration(
                labelText: '用户名',
                contentPadding: new EdgeInsets.only(bottom: 6.0),
              ),
              validator: (String val) {
                if(val.length == 0) {
                  return '用户名不能为空';
                }
                if(val.length > 12) {
                  return '用户名长度越界';
                }
              },
              onSaved: (String val) {
                username = val;
              },
            ),
            new TextFormField(
              obscureText: true,
              style: new TextStyle(fontSize: 18.0, color: Theme.of(context).textTheme.body1.color),
              decoration: new InputDecoration(
                labelText: '密码',
                contentPadding: new EdgeInsets.only(bottom: 6.0),
              ),
              validator: (String val) {
                if(val.length == 0) {
                  return '密码不能为空';
                }
                if(val.length > 24) {
                  return '密码长度越界';
                }
              },
              onSaved: (String val) {
                password = val;
              },
            ),
            new Builder(
              builder: (BuildContext context) {
                return new MaterialButton(
                  height: 44.0,
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    FormState state = Form.of(context);
                    if(state.validate()) {
                      state.save();
                      _doLogin(context);
                    }
                  },
                  child: new Text('登录', style: const TextStyle(fontSize: 18.0),),
                );
              },
            ),
          ].map((child) {
            return new Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: child,
            );
          }).toList()
        ),
      ),
    );
  }

}