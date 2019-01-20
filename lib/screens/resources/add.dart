import 'package:flutter/material.dart';
import 'package:biricik/db/dbHelper.dart';
import 'package:biricik/models/resource.dart';

class ResourceAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ResourceAddState();
}

class ResourceAddState extends State<ResourceAdd> {
  DbHelper dbHelper = new DbHelper();

  TextEditingController txtName = new TextEditingController();
  TextEditingController txtDescription = new TextEditingController();
  TextEditingController txtUrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add a new resource"),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
          child: Column(
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
        ));
  }

  void save() async {
    int result = await dbHelper.insert(
      Resource(txtName.text, txtDescription.text, txtUrl.text),
    );

    if (result != 0) {
      Navigator.pop(context, true);
    }
  }
}
