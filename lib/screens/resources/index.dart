import 'package:flutter/material.dart';
import 'package:biricik/screens/resources/list.dart';

import 'package:biricik/db/dbHelper.dart';

class ResourcesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DbHelper dbHelper = new DbHelper();
    dbHelper.initializeDb().then((result) {
      print("Resource Database is created!");
    });
    return ResourceList();
  }
}
