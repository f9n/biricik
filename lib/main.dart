import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:biricik/routes.dart';

void main() {
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.landscapeLeft, DeviceOrientation.portraitUp],
  );
  runApp(BiricikApp());
}

class BiricikApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biricik',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: routes,
    );
  }
}
