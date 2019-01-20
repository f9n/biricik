import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:biricik/screens/settings/index.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> _counter;
  double _sliderValue = 10.0;
  double _sliderMax = 30.0;
  double _sliderMin = 0.0;
  double _sliderRange = 5.0;

  @override
  void initState() {
    super.initState();
    _counter = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt('counter') ?? 0);
    });
  }

  Future<Null> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;

    setState(() {
      _counter = prefs.setInt("counter", counter).then((bool success) {
        return counter;
      });
    });
  }

  // Dashboard, Icons.border_all
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Biricik"),
        actions: <Widget>[
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
            Text(
              'You have pushed the button this many times:',
            ),
            FutureBuilder<int>(
              future: _counter,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else
                      return Text(
                        'Button tapped ${snapshot.data} time${snapshot.data == 1 ? '' : 's'}.',
                      );
                }
              },
            ),
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
