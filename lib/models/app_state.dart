library app_state;
import 'package:flutter_wills_gen/wills.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/models/models.dart';

part 'app_state.g.dart';

@wills
abstract class AppState extends Object with Reactive {

  User activeUser;

  ObservableMap<int, Topic> topics;

  ObservableMap<int, Category> categories;

  ObservableMap<int, User> users;

  AppState.$();

  factory AppState({
    User activeUser,
    ObservableMap<int, Topic> topics,
    ObservableMap<int, Category> categories,
    ObservableMap<int, User> users
  }) = _$AppState;
}