import 'package:flutter/material.dart';
import 'package:biricik/db/dbHelper.dart';
import 'package:biricik/models/resource.dart';
import 'package:biricik/widgets/uv4l_camera_control.dart';

enum Choice { Delete, Update }

class ResourceDetail extends StatefulWidget {
  Resource resource;

  ResourceDetail(this.resource);

  @override
  State<StatefulWidget> createState() => ResourceDetailState();
}

class ResourceDetailState extends State<ResourceDetail> {
  DbHelper dbHelper = new DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resource Detail for ${widget.resource.name}"),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  title: Text("Cihaz Adı : ${widget.resource.name}"),
                ),
                ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  title:
                      Text("Cihaz Açıklaması : ${widget.resource.description}"),
                ),
                ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  title: Text("Url Adresi : ${widget.resource.url}"),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // goToCameraConfigurations();
        },
        tooltip: "Go to Camera Configurations",
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  void goToCameraConfigurations() async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Uv4lCameraConfigurationScreen(
              name: widget.resource.name,
              url: widget.resource.url,
            ),
      ),
    );
    if (result != null && result) {
      print('Loading...');
    }
  }
}
