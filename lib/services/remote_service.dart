import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:nodebb/services/cookie_jar.dart';
import 'package:nodebb/utils/utils.dart' as utils;


class RemoteService {

  String _host;

  bool _security;

  Client client;

  CookieJar jar;

  static final RemoteService service = new RemoteService._();

  RemoteService._() {
   client = new Client();
   jar = new CookieJar();
  }
  //http://dart.goodev.org/guides/language/effective-dart/design
  //虽然推荐用工厂构造函数
  //但是还是Java的比较直观
  static RemoteService getInstance() {
    return service;
  }

  setup(String host, [bool security = false]) {
    this._host = host;
    this._security = security;
  }

  Future<Response> open(Uri uri, {String method = 'get', Map<String, String> body}) async {
    List<Cookie> cookies = jar.getCookies(uri) ?? [];
    Map<String, String> headers = new Map();
    headers[HttpHeaders.COOKIE] = jar.serializeCookies(cookies);
    Response res;
    if(method == 'get') {
      res = await client.get(uri, headers: headers);
    } else if(method == 'post') {
      res = await client.post(uri, headers: headers, body: body);
    }
    Cookie cookie;
    if(res.headers[HttpHeaders.SET_COOKIE] != null) {
      cookie = new Cookie.fromSetCookieValue(res.headers[HttpHeaders.SET_COOKIE]);
    }
    if(cookie != null) {
      cookie.domain = cookie.domain ?? uri.host;
      jar.add(cookie);
    }
    return res;
  }

  Future<Response> get(Uri uri) async {
    return open(uri);
  }

  Future<Response> post(Uri uri, [Map<String, String> body]) async {
    return open(uri, method: 'post', body: body);
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
    Response res = await get(_buildUrl('/api/mobile/v1/topics', params));
    return utils.decodeJSON(res.body);
  }

  Future<Map> fetchTopicDetail(int tid) async {
    Response res = await get(_buildUrl('/api/mobile/v1/topics/${tid}'));
    return utils.decodeJSON(res.body);
  }
  
  Future<Map> doLogin(usernameOrEmail, password) async {
    Response res = await post(_buildUrl('/api/mobile/v1/auth/login'),
        {'username': usernameOrEmail, 'password': password});
    return utils.decodeJSON(res.body);
  }
}
