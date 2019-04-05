import 'dart:async';

import 'package:http/http.dart' as http;

Future<bool> isAlive(String uri) async {
  try {
    await http.get(uri);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}
