import 'dart:convert';

import 'package:flutter/material.dart';

bool isEmpty(val) {
  return val == null || val == '';
}

int convertToInteger([num = -1]) {
  if(null == num) return 0;
  return num.runtimeType == int ? num : int.parse(num);
}

Color parseColorFromStr([String colorStr = '#000000']) {
  int colorVal = int.parse('ff' + colorStr.substring(1, colorStr.length), radix: 16);
  return new Color(colorVal);
}

String encodeUriQuery(Map<String, String> query) {
  if(query == null) return '';
  StringBuffer sb = new StringBuffer();
  query.forEach((key, value) {
    if(sb.length > 0) sb.write('&');
    sb.write(Uri.encodeQueryComponent(key));
    sb.write('=');
    sb.write(Uri.encodeQueryComponent(value));
  });
  return sb.toString();
}

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

Map handleNodeBBResponse(String res) {
  RegExp exp = new RegExp(r"^\[\[(\w+):([a-zA-Z_\-]+)\]\]$");
  Iterable<Match> matches = exp.allMatches(res);
  var json;
  if(matches.first != null) {
    json = {
      matches.first.group(1): matches.first.group(2)
    };
  }
  return json;
}

Map decodeJSON(String data) {
  var json;
  try {
    json = JSON.decode(data);
  } catch(e) {
   json = handleNodeBBResponse(data);
   if(json == null) {
     throw e;
   }
   if(json['error'] != null) {
     throw new Exception(data);
   }
  }
  return json;
}