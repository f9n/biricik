import 'package:flutter/material.dart';

import 'package:biricik/screens/home/index.dart';
import 'package:biricik/screens/resources/index.dart';
import 'package:biricik/screens/settings/index.dart';
import 'package:biricik/screens/dashboards/index.dart';

final routes = <String, WidgetBuilder>{
  '/': (BuildContext context) => HomeScreen(),
  '/resources': (BuildContext context) => ResourcesScreen(),
  '/dashboards': (BuildContext context) => DashboardsScreen(),
  '/settings': (BuildContext context) => SettingsScreen(),
};
