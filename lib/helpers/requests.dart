import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> getDistance(String uri) async {
  try {
    var response = await http.get(uri);
    print(response.body);
    var parsed = json.decode(response.body);
    return parsed["data"];
  } catch (e) {
    print(e);
    return "None";
  }
}
