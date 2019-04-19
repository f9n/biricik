import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:biricik/db/dbHelper.dart';
import 'package:biricik/models/resource.dart';

import 'package:biricik/screens/dashboards/panels/video_streaming.dart';
import 'package:biricik/screens/dashboards/panels/square.dart';
import 'package:biricik/screens/dashboards/panels/movement.dart';

class DashboardsScreen extends StatefulWidget {
  @override
  DashboardsScreenState createState() => DashboardsScreenState();
}

class DashboardsScreenState extends State<DashboardsScreen> {
  DbHelper dbHelper = new DbHelper();
  SharedPreferences sharedPreferences;

  Future<Resource> _getDefaultResource() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var defaultResourceId = sharedPreferences.getInt('defaultResourceId');
    return dbHelper.getResourceById(defaultResourceId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboards"),
      ),
      body: FutureBuilder<Resource>(
        future: _getDefaultResource(),
        builder: (BuildContext context, AsyncSnapshot<Resource> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            var url = snapshot.data.url;
            return Stack(
              children: <Widget>[
                // VideoStreamingWidget(url: url),
                SquareWidget(),
                MovementWidget(
                  url: url,
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
