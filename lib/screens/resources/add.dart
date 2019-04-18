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
  TextEditingController txtUrl = new TextEditingController(text: "https://");

  String addedDate = now.toString();

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
