library app_state;
import 'package:built_value/built_value.dart';
import 'package:nodebb/models/post.dart';
import 'package:nodebb/models/user.dart';
import 'package:nodebb/models/topic.dart';
import 'package:nodebb/models/category.dart';
import 'package:nodebb/models/collection.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {

  Collection<int, Topic> get topics;

  Collection<int, User> get users;

  Collection<int, Category> get categories;

  Collection<int, Post> get posts;

  AppState._();
  factory AppState([updates(AppStateBuilder b)]) = _$AppState;
}