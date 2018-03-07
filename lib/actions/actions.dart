library actions;
import 'package:built_redux/built_redux.dart';
import 'package:nodebb/models/models.dart';

part 'actions.g.dart';

abstract class AppActions extends ReduxActions {
  //这里泛型是传递给action playload类型
  ActionDispatcher<Null> get fetchTopics;

  ActionDispatcher<int> get fetchTopicDetail;

  ActionDispatcher<int> get fetchUser;

  ActionDispatcher<Map<String, String>> get doLogin;

  ActionDispatcher<RequestStatus> get updateFetchTopicStatus;

  ActionDispatcher<RequestStatus> get updateFetchTopicDetailStatus;

  ActionDispatcher<RequestStatus> get updateFetchUserStatus;

  ActionDispatcher<RequestStatus> get updateDoLoginStatus;

  ActionDispatcher<List<Topic>> get addTopics;

  ActionDispatcher<List<User>> get addUsers;

  ActionDispatcher<List<Post>> get addPosts;

  ActionDispatcher<User> get setActiveUser;

  AppActions._();

  factory AppActions() => new _$AppActions();
}
