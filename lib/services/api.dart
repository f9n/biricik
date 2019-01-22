import 'dart:async';
import 'package:http/http.dart' as http;

class API {
  static Future getResourceInfo(String url) {
    return http.get(url);
  }
}
