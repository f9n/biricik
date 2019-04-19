import 'package:flutter/material.dart';

import 'package:biricik/screens/settings/index.dart';

import 'package:badge/badge.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _sliderValue = 10.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Biricik"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () => Navigator.pushNamed(context, '/about'),
          ),
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () => Navigator.pushNamed(context, '/help'),
          ),
          IconButton(
            icon: Icon(Icons.border_all),
            onPressed: () => Navigator.pushNamed(context, '/dashboards'),
          ),
          IconButton(
            icon: Icon(Icons.desktop_windows),
            onPressed: () => Navigator.pushNamed(context, '/resources'),
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Slider(
              activeColor: Colors.indigoAccent,
              min: 0.0,
              max: 30.0,
              divisions: (30.0 ~/ 5.0),
              onChanged: (newRating) {
                setState(() => _sliderValue = newRating);
              },
              value: _sliderValue,
            ),
            Text("Slider Value $_sliderValue"),
            Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.grey,
              child: Badge.before(
                value: "Text",
                child: Text("button"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
