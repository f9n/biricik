import 'package:flutter/material.dart';

import 'package:biricik/screens/dashboards/panels/video_streaming/index.dart';
import 'package:biricik/screens/dashboards/panels/square.dart';
import 'package:biricik/screens/dashboards/panels/movement.dart';

class DashboardsScreen extends StatefulWidget {
  @override
  DashboardsScreenState createState() => DashboardsScreenState();
}

class DashboardsScreenState extends State<DashboardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboards"),
      ),
      body: Stack(
        children: <Widget>[
          // VideoStreamingWidget(),
          SquareWidget(),
          MovementWidget()
        ],
      ),
    );
  }
}
