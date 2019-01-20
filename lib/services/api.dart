import 'package:http/http.dart' as http;

class Api {
  static Future getResourceInfo(String url) {
    return http.get(url);
  }
}
