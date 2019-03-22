import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: <Widget>[
          FutureBuilder<SharedPreferences>(
            future: _prefs,
            builder: (BuildContext context,
                AsyncSnapshot<SharedPreferences> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const CircularProgressIndicator();
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');

                  var defaultResourceId =
                      snapshot.data.getInt('defaultResourceId') ?? Null;
                  return Text(
                      'Default Resource Id: ${defaultResourceId == Null ? 'Not Defined' : defaultResourceId}');
              }
            },
          ),
        ],
      ),
    );
  }
}
