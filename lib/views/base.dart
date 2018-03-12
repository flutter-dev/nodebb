import 'package:flutter/material.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/models/models.dart';

abstract class BasePage extends StatefulWidget {
  final Map<String, Object> routeParams;
  BasePage({key, routeParams})
      : routeParams = routeParams,
        super(key: key);
}

abstract class BaseReactivePage extends BaseReactiveWidget {
  final Map<String, Object> routeParams;
  BaseReactivePage({key, routeParams})
      : routeParams = routeParams,
        super(key: key);
}

abstract class BaseReactiveState<W extends ReactiveWidget> extends ReactiveState<Store<AppState>, W> {}

abstract class BaseReactiveWidget extends ReactiveWidget {

  BaseReactiveWidget({key}): super(key: key);

  @override
  BaseReactiveState<ReactiveWidget> createState();


}