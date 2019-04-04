import 'package:flutter/material.dart';
import 'package:biricik/db/dbHelper.dart';
import 'package:biricik/models/resource.dart';

DateTime now = DateTime.now();

class ResourceAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ResourceAddState();
}

class ResourceAddState extends State<ResourceAdd> {
  DbHelper dbHelper = new DbHelper();

  TextEditingController txtName = new TextEditingController();
  TextEditingController txtDescription = new TextEditingController();
  TextEditingController txtUrl = new TextEditingController();

  String addedDate = now.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new resource"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: txtName,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: txtDescription,
              decoration: InputDecoration(labelText: "Description"),
            ),
            TextField(
              controller: txtUrl,
              decoration: InputDecoration(labelText: "Url"),
            ),
            RaisedButton(
              child: Text('Save'),
              onPressed: save,
            ),
          ],
        ),
      ),
    );
  }

  void save() async {
    int result = await dbHelper.insert(
      Resource.withoutId(
        name: txtName.text,
        description: txtDescription.text,
        url: txtUrl.text,
        addedDate: addedDate,
      ),
    );

    if (result != 0) {
      Navigator.pop(context, true);
    }
  }
}
