import 'package:flutter/material.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/views/base.dart';
import 'package:nodebb/views/messages_fragment.dart';
import 'package:nodebb/views/personal_fragment.dart';
import 'package:nodebb/views/topics_fragment.dart';


class HomePage extends BaseReactivePage {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends BaseReactiveState<HomePage> with TickerProviderStateMixin {

  int _currentIndex = 0;

  TabController _controller;

  @override
  void initState() {
    super.initState();
    this._controller = new TabController(initialIndex: this._currentIndex, length: 3, vsync: this);
    this._controller.addListener(() {
      this.setState(() {
        this._currentIndex = this._controller.index;
      });
    });
  }

  Widget _buildBottomNavBarIcon(IconData icon, [bool marked = false]) {
    var children = <Widget>[];
    if(marked) {
      children.add(new Positioned(
        right: -4.0,
        top: -4.0,
        child: marked ? new Container(
          width: 8.0,
          height: 8.0,
          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
        ) : null,
      ));
    }
    children.add(new Icon(icon));
    return new Stack(
      overflow: Overflow.visible,
      children: children
    );
  }


  BottomNavigationBar _buildBottomNavBar() {
    UnreadInfo info = $store.state.unreadInfo;
    return new BottomNavigationBar(
      currentIndex: this._currentIndex,
      items: <BottomNavigationBarItem>[
        new BottomNavigationBarItem(
          icon: _buildBottomNavBarIcon(Icons.explore, $store.state.notification.newTopic),
          title: const Text('话题', style: const TextStyle(fontSize: 12.0))
        ),
        new BottomNavigationBarItem(
          icon: _buildBottomNavBarIcon(Icons.message, info.unreadChatCount > 0),
          title: const Text('消息', style: const TextStyle(fontSize: 12.0))
        ),
        new BottomNavigationBarItem(
          icon: _buildBottomNavBarIcon(Icons.person, false),
          title: const Text('个人', style: const TextStyle(fontSize: 12.0))
        )
      ],
      onTap: (int index) {
        this._controller.animateTo(index);
      }
    );
  }


  @override
  Widget render(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(widget.title)
      ),
      body: new NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification) {
            //print(ScrollNotification.toString());
          },
          child: new TabBarView(
              controller: this._controller,
              children: [
                new TopicsFragment(key: new ValueKey<String>('TopicsFragment')),
                new MessagesFragment(key: new ValueKey<String>('MessagesFragment')),
                new PersonalFragment(key: new ValueKey<String>('PersonalFragment'))
              ]
          )
      ),
      bottomNavigationBar: this._buildBottomNavBar(),
    );
  }
}
