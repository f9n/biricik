import 'dart:async';

import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  void navigateToHome() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  void initState() {
    super.initState();
    var _duration = Duration(seconds: 5);
    Timer(_duration, navigateToHome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo.png'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.0),
            ),
            Container(
              width: 500.0,
              child: LinearProgressIndicator(
                backgroundColor: Colors.yellow,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Text(
              "Loading...",
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
