import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  int defaultResourceId = 3;

  @override
  void initState() {
    super.initState();
    _loadDefaultResourceId();
  }

  _loadDefaultResourceId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      defaultResourceId = (prefs.getInt('defaultResourceId') ?? 0);
    });
  }

  _setDefaultResourceId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('defaultResourceId', id);
      defaultResourceId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (resources == null) {
      getResourcesData();
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
        Resource resource = this.resources[position];
        var resourceIcon = resource.id == defaultResourceId
            ? Icons.bookmark
            : Icons.bookmark_border;

        return Card(
          color: Colors.amberAccent,
          elevation: 2.0,
          child: ListTile(
            leading: Icon(resourceIcon),
            title: Text(resource.name),
            subtitle: Text(resource.description),
            onTap: () {
              goToDetail(resource);
            },
            onLongPress: () => _setDefaultResourceId(resource.id),
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
      getResourcesData();
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
      getResourcesData();
    }
  }

  void getResourcesData() {
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
