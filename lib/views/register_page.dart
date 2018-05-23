import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nodebb/views/base.dart';

class RegisterPage extends BasePage {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  Widget build(BuildContext context) {
    return new Text('注册');
  }

}