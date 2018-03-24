library app_state;
import 'package:flutter_wills_gen/wills.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/models/notification.dart';
import 'package:nodebb/models/room.dart';
import 'package:nodebb/models/unread_info.dart';
import 'package:nodebb/socket_io/socket_io.dart';

part 'app_state.g.dart';

@wills
abstract class AppState extends Object with Reactive {

  User activeUser;

  UnreadInfo unreadInfo;

  NodeBBNotification notification;

  ObservableMap<int, Topic> topics;

  ObservableMap<int, Category> categories;

  ObservableMap<int, User> users;

  ObservableMap<int, Room> rooms;

  AppState.$();

  factory AppState({
    UnreadInfo unreadInfo,
    User activeUser,
    NodeBBNotification notification,
    ObservableMap<int, Topic> topics,
    ObservableMap<int, Category> categories,
    ObservableMap<int, User> users,
    ObservableMap<int, Room> rooms
  }) = _$AppState;
}