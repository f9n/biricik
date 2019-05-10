import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
  TextEditingController txtUrl = new TextEditingController(text: "http://");

  String addedDate = now.toString();

  @override
  void dispose() {
    txtUrl.dispose();
    txtDescription.dispose();
    txtName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new resource"),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5.0),
            ),
            TextField(
              controller: txtName,
              decoration: InputDecoration(
                labelText: "Name",
                hintText: "r3-d3",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              keyboardType: TextInputType.text,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            TextField(
              controller: txtDescription,
              decoration: InputDecoration(
                labelText: "Description",
                hintText: "My starwars robot",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              keyboardType: TextInputType.text,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            TextField(
              controller: txtUrl,
              decoration: InputDecoration(
                labelText: "Url",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              keyboardType: TextInputType.url,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            RaisedButton(
              child: Text('Save'),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: save,
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(String msg) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert"),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void save() async {
    if (txtName.text == "" || txtDescription.text == "" || txtUrl.text == "") {
      _showDialog("Name or description or url can not be empty.");
      return;
    }
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
