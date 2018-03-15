import 'package:flutter/material.dart';

buildBottomDividerDecoration(BuildContext context) {
  return new BoxDecoration(
      border: new Border(bottom: new BorderSide(
        color: Theme.of(context).dividerColor
      ))
  );
}