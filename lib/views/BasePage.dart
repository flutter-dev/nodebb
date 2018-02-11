import 'package:flutter/material.dart';

abstract class BasePage extends StatefulWidget {
  final Map<String, Object> routeParams;
  BasePage({key, routeParams})
      : routeParams = routeParams,
        super(key: key);
}