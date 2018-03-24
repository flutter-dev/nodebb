import 'package:flutter/material.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/enums/enums.dart';
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

abstract class BaseReactiveState<W extends ReactiveWidget> extends ReactiveState<Store<AppState>, W>  {
  $confirm(String content, {
    onConfirm,
    onCancel,
    String onConfirmBtnTxt = '确定',
    String onCancelBtnTxt = '取消',
    DialogMode mode = DialogMode.CONFIRM
  }) {
    List<Widget> children = new List();
    if(mode == DialogMode.CONFIRM) {
      children.add(new FlatButton(
          child: new Text(onCancelBtnTxt),
          onPressed: () async {
            if(onCancel != null) {
              await onCancel();
            }
            Navigator.pop(context, false);
          }
      ));
    }
    children.add(new FlatButton(
        child: new Text(onConfirmBtnTxt),
        onPressed: () async {
          if(onConfirm != null) {
            await onConfirm();
          }
          Navigator.pop(context, true);
        }
    ));
    return showDialog(
      context: context,
      child: new AlertDialog(
        content: new Text(content),
        actions: children,
      ),
    );
  }

  $alert(String content, {
    onConfirm,
    String onConfirmBtnTxt = '确定'
  }) {
    return $confirm(content, onConfirm: onConfirm, onConfirmBtnTxt: onConfirmBtnTxt, mode: DialogMode.ALERT);
  }
}

abstract class BaseReactiveWidget extends ReactiveWidget {

  BaseReactiveWidget({key}): super(key: key);

  @override
  BaseReactiveState<ReactiveWidget> createState();


}