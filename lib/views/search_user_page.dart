import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/enums/enums.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/services/io_service.dart';
import 'package:nodebb/services/remote_service.dart';
import 'package:nodebb/views/base.dart';
import 'package:nodebb/widgets/builders.dart';
import 'package:nodebb/widgets/widgets.dart';
import 'package:nodebb/utils/utils.dart' as utils;

class SearchUserPage extends BaseReactivePage {

  SearchUserPage({Key key, routeParams}) : super(key: key, routeParams: routeParams);

  @override
  _SearchUserPageState createState() => new _SearchUserPageState();
}

class _SearchUserPageState extends BaseReactiveState<SearchUserPage> {

  ReactiveProp<RequestStatus> status = new ReactiveProp();

  ObservableList<User> users = new ObservableList();

  TextEditingController _textController =  new TextEditingController();
  
  Timer _timer;

  SliverGridDelegate _delegate = new SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 90.0,
    mainAxisSpacing: 6.0,
    crossAxisSpacing: 2.0
  );


  @override
  void initState() {
    super.initState();
    _fetchContent();
    _textController.addListener(this._updateContent);
  }

  _fetchContent() {
    status.self = RequestStatus.PENDING;
    RemoteService.getInstance().fetchUsers().then((results) {
      List jsons = results['users'] ?? [];
      users.clear();
      jsons.forEach((data) {
        users.add(new User.fromJSON(data));
      });
      if(users.isNotEmpty) {
        status.self = RequestStatus.SUCCESS;
      } else {
        status.self = RequestStatus.EMPTY;
      }
    }).catchError((err) {
      status.self = RequestStatus.ERROR;
    });
  }

  _updateContent() async {
    _timer?.cancel();
    _timer = new Timer(const Duration(milliseconds: 200), () async {
      if(!utils.isEmpty(_textController.text)) {
        status.self = RequestStatus.PENDING;
        List<User> data = await IOService.getInstance().searchUser(
            query: _textController.text);
        users.clear();
        users.addAll(data);
        if(users.isNotEmpty) {
          status.self = RequestStatus.SUCCESS;
        } else {
          status.self = RequestStatus.EMPTY;
        }
      } else {
        _fetchContent();
      }
    });
  }

  _buildAvatar(User user) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Expanded(
            child: new Container(
                width: 80.0,
                height: 80.0,
                alignment: Alignment.center,
                child: new NodeBBAvatar(
                  picture: user.picture,
                  iconBgColor: user.iconBgColor,
                  iconText: user.iconText,
                )
            )
        ),
        new Padding(padding: const EdgeInsets.only(top: 2.0)),
        new Text(user.userName, overflow: TextOverflow.ellipsis, maxLines: 1,)
      ],
    );
  }

  @override
  Widget render(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('查找用户')),
      body: new Container(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: new Column(
          children: <Widget>[
            new Container(
                height: 56.0,
                child: new TextField(controller: _textController, maxLines: 1)
            ),
            new Expanded(
              child: buildPendingBody(status: status.self, bodyBuilder: () {
                return new ScrollConfiguration(
                  behavior: new CustomScrollBehavior(),
                  child: new GridView.builder(
                    gridDelegate: _delegate,
                    itemCount: users.length,
                    itemBuilder: (BuildContext context, int index) {
                      User user = users[index];
                      return new GestureDetector(
                        child: _buildAvatar(user),
                        onTap: () {
                          $store.state.shareStorage['user_info_page'] = user;
                          Navigator.of(context).pushNamed('/users/${user.uid}');
                        }
                      );
                    })
                );
              })
            )
          ],
        )
      )
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    _textController.removeListener(this._updateContent);
    super.dispose();
  }
}