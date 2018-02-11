import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';


class RemoteService {
  String _host;

  bool _security;

  static final RemoteService service = new RemoteService._();

  RemoteService._();
  //http://dart.goodev.org/guides/language/effective-dart/design
  //虽然推荐用工厂构造函数
  //但是还是Java的比较直观
  static RemoteService getInstance() {
    return service;
  }

  setup(String host, {bool security = false}) {
    this._host = host;
    this._security = security;
  }

  Uri _buildUrl(String path, [Map<String, String> params]) {
    if(_security) {
      return new Uri.https(_host, path, params);
    } else {
      return new Uri.http(_host, path, params);
    }
  }

  Future<Map> fetchTopics([int start = 0, int count = 20]) async {
    var params = <String, String>{'after': start.toString(), 'count': count.toString()};
    Response res = await get(_buildUrl('/api/mobile/v1/topics', params).toString());
    return JSON.decode(res.body);
  }

  Future<Map> fetchTopicDetail(int tid) async {
    Response res = await get(_buildUrl('/api/mobile/v1/topics/${tid}'));
    return JSON.decode(res.body);
  }
}