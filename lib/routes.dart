import 'package:flutter/material.dart';

import 'package:biricik/screens/start/index.dart';
import 'package:biricik/screens/home/index.dart';
import 'package:biricik/screens/resources/index.dart';
import 'package:biricik/screens/settings/index.dart';
import 'package:biricik/screens/dashboards/index.dart';
import 'package:biricik/screens/about/index.dart';
import 'package:biricik/screens/help/index.dart';

final routes = <String, WidgetBuilder>{
  '/': (BuildContext context) => StartScreen(),
  '/home': (BuildContext context) => HomeScreen(),
  '/resources': (BuildContext context) => ResourcesScreen(),
  '/dashboards': (BuildContext context) => DashboardsScreen(),
  '/settings': (BuildContext context) => SettingsScreen(),
  '/about': (BuildContext context) => AboutScreen(),
  '/help': (BuildContext context) => HelpScreen(),
};
