import 'package:flutter/material.dart';
import 'package:biricik/screens/resources/add.dart';
import 'package:biricik/screens/resources/detail.dart';
import 'package:biricik/db/dbHelper.dart';
import 'package:biricik/models/resource.dart';

class ResourceList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ResourceListState();
}

class ResourceListState extends State<ResourceList> {
  DbHelper dbHelper = new DbHelper();
  List<Resource> resources;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (resources == null) {
      getData();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Resources"),
      ),
      body: resourceListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToResourceAdd();
        },
        tooltip: "Add new Resource",
        child: Icon(Icons.add),
      ),
    );
  }

  ListView resourceListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        var resource = this.resources[position];
        return Card(
          color: Colors.amberAccent,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              child: Text("A"),
            ),
            title: Text(resource.name),
            subtitle: Text(resource.description),
            onTap: () {
              goToDetail(resource);
            },
          ),
        );
      },
    );
  }

  void goToDetail(Resource resource) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResourceDetail(resource),
      ),
    );
    if (result != null && result) {
      getData();
    }
  }

  void goToResourceAdd() async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResourceAdd(),
      ),
    );
    if (result != null && result) {
      getData();
    }
  }

  void getData() {
    var dbFuture = dbHelper.initializeDb();
    dbFuture.then((result) {
      var resourcesFuture = dbHelper.getResources();
      resourcesFuture.then((data) {
        setState(() {
          resources = data;
          count = data.length;
        });
      });
    });
  }
}
