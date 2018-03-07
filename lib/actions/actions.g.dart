// GENERATED CODE - DO NOT MODIFY BY HAND

part of actions;

// **************************************************************************
// Generator: BuiltReduxGenerator
// **************************************************************************

class _$AppActions extends AppActions {
  factory _$AppActions() => new _$AppActions._();
  _$AppActions._() : super._();

  final ActionDispatcher<Null> fetchTopics =
      new ActionDispatcher<Null>('AppActions-fetchTopics');
  final ActionDispatcher<int> fetchTopicDetail =
      new ActionDispatcher<int>('AppActions-fetchTopicDetail');
  final ActionDispatcher<int> fetchUser =
      new ActionDispatcher<int>('AppActions-fetchUser');
  final ActionDispatcher<Map<String, String>> doLogin =
      new ActionDispatcher<Map<String, String>>('AppActions-doLogin');
  final ActionDispatcher<RequestStatus> updateFetchTopicStatus =
      new ActionDispatcher<RequestStatus>('AppActions-updateFetchTopicStatus');
  final ActionDispatcher<RequestStatus> updateFetchTopicDetailStatus =
      new ActionDispatcher<RequestStatus>(
          'AppActions-updateFetchTopicDetailStatus');
  final ActionDispatcher<RequestStatus> updateFetchUserStatus =
      new ActionDispatcher<RequestStatus>('AppActions-updateFetchUserStatus');
  final ActionDispatcher<RequestStatus> updateDoLoginStatus =
      new ActionDispatcher<RequestStatus>('AppActions-updateDoLoginStatus');
  final ActionDispatcher<List<Topic>> addTopics =
      new ActionDispatcher<List<Topic>>('AppActions-addTopics');
  final ActionDispatcher<List<User>> addUsers =
      new ActionDispatcher<List<User>>('AppActions-addUsers');
  final ActionDispatcher<List<Post>> addPosts =
      new ActionDispatcher<List<Post>>('AppActions-addPosts');
  final ActionDispatcher<User> setActiveUser =
      new ActionDispatcher<User>('AppActions-setActiveUser');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    fetchTopics.setDispatcher(dispatcher);
    fetchTopicDetail.setDispatcher(dispatcher);
    fetchUser.setDispatcher(dispatcher);
    doLogin.setDispatcher(dispatcher);
    updateFetchTopicStatus.setDispatcher(dispatcher);
    updateFetchTopicDetailStatus.setDispatcher(dispatcher);
    updateFetchUserStatus.setDispatcher(dispatcher);
    updateDoLoginStatus.setDispatcher(dispatcher);
    addTopics.setDispatcher(dispatcher);
    addUsers.setDispatcher(dispatcher);
    addPosts.setDispatcher(dispatcher);
    setActiveUser.setDispatcher(dispatcher);
  }
}

class AppActionsNames {
  static final ActionName<Null> fetchTopics =
      new ActionName<Null>('AppActions-fetchTopics');
  static final ActionName<int> fetchTopicDetail =
      new ActionName<int>('AppActions-fetchTopicDetail');
  static final ActionName<int> fetchUser =
      new ActionName<int>('AppActions-fetchUser');
  static final ActionName<Map<String, String>> doLogin =
      new ActionName<Map<String, String>>('AppActions-doLogin');
  static final ActionName<RequestStatus> updateFetchTopicStatus =
      new ActionName<RequestStatus>('AppActions-updateFetchTopicStatus');
  static final ActionName<RequestStatus> updateFetchTopicDetailStatus =
      new ActionName<RequestStatus>('AppActions-updateFetchTopicDetailStatus');
  static final ActionName<RequestStatus> updateFetchUserStatus =
      new ActionName<RequestStatus>('AppActions-updateFetchUserStatus');
  static final ActionName<RequestStatus> updateDoLoginStatus =
      new ActionName<RequestStatus>('AppActions-updateDoLoginStatus');
  static final ActionName<List<Topic>> addTopics =
      new ActionName<List<Topic>>('AppActions-addTopics');
  static final ActionName<List<User>> addUsers =
      new ActionName<List<User>>('AppActions-addUsers');
  static final ActionName<List<Post>> addPosts =
      new ActionName<List<Post>>('AppActions-addPosts');
  static final ActionName<User> setActiveUser =
      new ActionName<User>('AppActions-setActiveUser');
}
