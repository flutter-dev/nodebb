import 'dart:io';

class CookieRecord {

  DateTime createTime;

  Cookie cookie;

  CookieRecord({this.cookie, this.createTime}) {
    if(createTime == null) {
      createTime = new DateTime.now();
    }
  }

}

class CookieJar {
  Map<String, List<CookieRecord>> store = new Map();

  CookieJar();

  add(Cookie cookie) {

//    if(cookie.domain != null) {
//      cookie.domain =
//      cookie.domain.startsWith('.') ? cookie.domain.substring(1) : cookie.domain;
//    }

    if(store[cookie.domain] == null) {
      store[cookie.domain] = new List<CookieRecord>();
    }

    List<CookieRecord> records = store[cookie.domain];
    for(int i = 0; i < records.length; i++) {
      if(records[i].cookie.name == cookie.name
          && records[i].cookie.path == cookie.path
          && records[i].cookie.domain == cookie.domain
          && records[i].cookie.secure == cookie.secure) {
        records[i].cookie = cookie;
        records[i].createTime = new DateTime.now();
        return;
      }
    }
    records.add(new CookieRecord(cookie: cookie));

  }

  List<Cookie> getCookies(Uri uri) {
    List<CookieRecord> records = new List();
    store.keys.forEach((domain) {
      if(domain == uri.host) {
        records.addAll(store[domain]);
      }
      //var d = domain.startsWith('.') ? domain : '.' + domain;
      if(domain.startsWith('.') && uri.host.endsWith(domain)) {
        records.addAll(store[domain]);
      }
    });
    List<Cookie> cookies = new List();
    for(CookieRecord record in records) {
      if(record.cookie.maxAge != null) {
        if(record.createTime.add(new Duration(seconds: record.cookie.maxAge))
            .compareTo(new DateTime.now()) <= 0) {
          continue;
        }
      }
      if(record.cookie.maxAge == null && record.cookie.expires != null) {
        if(record.cookie.expires.compareTo(new DateTime.now()) <= 0) {
          continue;
        }
      }
      if((record.cookie.secure && (uri.scheme != 'https' && uri.scheme != 'wss'))
          || (!record.cookie.secure && (uri.scheme != 'http' && uri.scheme != 'ws'))) {
        continue;
      }
      if(!uri.path.startsWith(record.cookie.path)) {
        continue;
      }
      cookies.add(record.cookie);
    }
    return cookies.length > 0 ? cookies : null;
  }

  String serializeCookies(List<Cookie> cookies) {
    if(cookies == null) return null;
    StringBuffer sb = new StringBuffer();
    cookies.forEach((cookie) {
      if(sb.length > 0) {
        sb.write(';');
      }
      sb.write('${cookie.name}=${cookie.value}');
    });
    return sb.toString();
  }

  void clear() {
    store.clear();
  }
}