import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:nodebb/views/BasePage.dart';

class LoginPage extends BasePage {
  LoginPage({Key key, routeParams}) : super(key: key, routeParams: routeParams);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text('登录')
      ),
      body: new Form(
        child: new ListView( //只有ListView才可以在键盘弹出的情况下，内容可以滚动，Column是不行的
          padding: const EdgeInsets.fromLTRB(24.0, 96.0, 24.0, 0.0),
          children: [
            new TextFormField(
              decoration: new InputDecoration(labelText: '用户名', contentPadding: const EdgeInsets.symmetric(vertical: 2.0))
            ),
            new TextFormField(
              obscureText: true,
              decoration: new InputDecoration(labelText: '密码', contentPadding: const EdgeInsets.symmetric(vertical: 2.0)),
            ),
            new MaterialButton(
              height: 44.0,
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {},
              child: new Text('登录', style: const TextStyle(fontSize: 18.0),),
            )
          ].map((child) {
            return new Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: child,
            );
          }).toList()
        ),
      ),
//      body: new Center(
//        child: new Padding(
//          padding: new EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
//          child: new Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              new TextField(decoration: new InputDecoration(labelText: '用户名'),),
//              new TextField(decoration: new InputDecoration(labelText: '密码'),),
//              new MaterialButton(
//                color: Colors.blue,
//                textColor: Colors.white,
//                onPressed: null,
//                child: new Text('登录'),
//              )
//            ],
//          ),
//        )
//      )
    );
  }

}