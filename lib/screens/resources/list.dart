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
          print("Add new resource");
          //goToResourceAdd();
        },
        tooltip: "Add new Resource",
        child: Icon(Icons.add),
      ),
    );
  }

  _buildResourceItemWidget(Resource resource) {
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
          //goToDetail(resource);
        },
        onLongPress: () => _setDefaultResourceId(resource.id),
      ),
    );
  }
  /*
  ListView resourceListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        
      },
    );
    */
}

/*

  void goToDetail(Resource resource) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResourceDetail(resource),
      ),
    );
    if (result != null && result) {
      _loadResources();
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
      _loadResources();
    }
  }
}
*/
