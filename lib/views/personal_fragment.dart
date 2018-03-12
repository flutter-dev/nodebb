import 'package:flutter/material.dart';

class PersonalFragment extends StatefulWidget {
  PersonalFragment({Key key}): super(key: key);

  @override
  State createState() {
    return new _PersonalFragmentState();
  }
}

class _PersonalFragmentState extends State<PersonalFragment> {

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new Center(
            child: new Text('个人')
        )
    );
  }

}