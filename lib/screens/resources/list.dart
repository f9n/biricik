import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Resources"),
      ),
      body: FutureBuilder(
        future: dbHelper.getResources(),
        builder: (context, AsyncSnapshot<List<Resource>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data.map(_buildResourceItemWidget).toList(),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToResourceAdd();
        },
        tooltip: "Add new Resource",
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildResourceItemWidget(Resource resource) {
    print(resource);
    var resourceIcon = resource.id == defaultResourceId
        ? Icons.bookmark
        : Icons.bookmark_border;

    return Slidable(
      delegate: SlidableDrawerDelegate(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: Icon(resourceIcon),
          title: Text(resource.name),
          subtitle: Text(resource.description),
          onTap: () {
            goToDetail(resource);
          },
          onLongPress: () => _setDefaultResourceId(resource.id),
        ),
      ),
      actions: <Widget>[],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () async {
            var result = await dbHelper.delete(resource.id);
            if (result != 0) {
              setState(() {});
              AlertDialog alertDialog = new AlertDialog(
                title: Text("Success"),
                content: Text("Deleted resource: ${resource.name}"),
              );
              showDialog(context: context, builder: (_) => alertDialog);
            }
          },
        ),
      ],
    );
  }

  void goToResourceAdd() async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResourceAdd(),
      ),
    );
    print("Go To Resource Add  Page Result: ${result}");
  }

  void goToDetail(Resource resource) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResourceDetail(resource),
      ),
    );
    print("Go To Detail Page Result: ${result}");
  }
}
