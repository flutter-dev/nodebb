import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:nodebb/actions/actions.dart';
import 'package:nodebb/views/base.dart';

class CommentPage extends BaseReactivePage {


  CommentPage({Key key, routeParams}) : super(key: key, routeParams: routeParams);

  @override
  BaseReactiveState<CommentPage> createState() => new _CommentPageState();
}

class _CommentPageState extends BaseReactiveState<CommentPage> {
  String comment;

  _doPost(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    $store.dispatch(new PostCommentAction(
      topicId: int.parse(widget.routeParams['tid']),
      postId: null,
      comment: comment
    )).then((post) {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text('提交成功！'),
        backgroundColor: Colors.green,
      ));
      new Timer(const Duration(seconds: 1), () {
        Navigator.of(context).pop(post);
      });
    }).catchError((err) {
      print(err);
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text('提交失败！请重试'),
        backgroundColor: Colors.red,
      ));
    });
  }

  @override
  Widget render(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('回复：${$store.state.topics[int.parse(this.widget.routeParams['tid'])].title}')),
      body: new Container(
        margin: const EdgeInsets.all(16.0),
        child: new Form(
          child: new Column(
            children: <Widget>[
              new TextFormField(
                maxLength: 200,
                maxLines: 5,
                maxLengthEnforced: true,
                decoration: new InputDecoration(border: const OutlineInputBorder(borderSide: const BorderSide(width: 1.0))),
                validator: (String val) {
                  if(val.length == 0) {
                    return '回复不能为空';
                  }
                  if(val.length > 200) {
                    return '回复长度越界';
                  }
                  if(val.length < 10) {
                    return '回复长度太短';
                  }
                },
                onSaved: (String val) {
                  comment = val;
                },
              ),
              new Builder(
                builder: (BuildContext context) {
                  return new Row(
                      children: <Widget>[
                        new Expanded(
                            child: new Container(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: new MaterialButton(
                                height: 44.0,
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                onPressed: () {
                                  FormState state = Form.of(context);
                                  if(state.validate()) {
                                    state.save();
                                    _doPost(context);
                                  }
                                },
                                child: new Text('提交', style: const TextStyle(fontSize: 18.0),),
                              ),
                            )
                        )
                      ],
                  );
                },
              ),
            ],
          )
        ),
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }


}