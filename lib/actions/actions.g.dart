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
  final ActionDispatcher<List<Topic>> addTopics =
      new ActionDispatcher<List<Topic>>('AppActions-addTopics');
  final ActionDispatcher<List<User>> addUsers =
      new ActionDispatcher<List<User>>('AppActions-addUsers');
  final ActionDispatcher<List<Post>> addPosts =
      new ActionDispatcher<List<Post>>('AppActions-addPosts');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    fetchTopics.setDispatcher(dispatcher);
    fetchTopicDetail.setDispatcher(dispatcher);
    addTopics.setDispatcher(dispatcher);
    addUsers.setDispatcher(dispatcher);
    addPosts.setDispatcher(dispatcher);
  }
}

class AppActionsNames {
  static final ActionName<Null> fetchTopics =
      new ActionName<Null>('AppActions-fetchTopics');
  static final ActionName<int> fetchTopicDetail =
      new ActionName<int>('AppActions-fetchTopicDetail');
  static final ActionName<List<Topic>> addTopics =
      new ActionName<List<Topic>>('AppActions-addTopics');
  static final ActionName<List<User>> addUsers =
      new ActionName<List<User>>('AppActions-addUsers');
  static final ActionName<List<Post>> addPosts =
      new ActionName<List<Post>>('AppActions-addPosts');
}
