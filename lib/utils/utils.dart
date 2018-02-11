import 'package:flutter/material.dart';

bool isEmpty(val) {
  return val == null || val == '';
}

int convertToInteger([num = -1]) {
  return num.runtimeType == int ? num : int.parse(num);
}

Color parseColorFromStr([String colorStr = '#000000']) {
  int colorVal = int.parse('ff' + colorStr.substring(1, colorStr.length), radix: 16);
  return new Color(colorVal);
}

//bool routeMatches(String route, String matchesPath) => pathMatcher(route, matchesPath) != null;

//https://github.com/dartist/express/blob/master/lib/utils.dart
Map<String,String> pathMatcher(String routePath, String matchesPath){
  Map params = {};
  if (routePath == matchesPath) return params;
  List<String> pathComponents = matchesPath.split("/");
  List<String> routeComponents = routePath.split("/");
  if (pathComponents.length == routeComponents.length){
    for (int i=0; i<pathComponents.length; i++){
      String path = pathComponents[i];
      String route = routeComponents[i];
      if (path == route) continue;
      if (route.startsWith(":")) {
        params[route.substring(1)] = path;
        continue;
      }
      return null;
    }
    return params;
  }
  return null;
}