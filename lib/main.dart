import 'package:flutter/material.dart';

import 'package:biricik/routes.dart';

void main() => runApp(BiricikApp());

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
