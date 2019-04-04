import 'package:flutter/material.dart';
import 'package:biricik/db/dbHelper.dart';
import 'package:biricik/models/resource.dart';
import 'package:biricik/widgets/uv4l_camera_control.dart';

enum Choice { Delete, Update }

class ResourceDetail extends StatefulWidget {
  final Resource resource;

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
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            ListTile(
              title: Text("Device Name\n\n${widget.resource.name}"),
              leading: Icon(Icons.title),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              title: Text("Description\n\n${widget.resource.description}"),
              leading: Icon(Icons.description),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              title: Text("Added Date\n\n${widget.resource.addedDate}"),
              leading: Icon(Icons.date_range),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              title: Text("URI\n\n${widget.resource.url}"),
              leading: Icon(Icons.device_hub),
            ),
            Divider(
              color: Colors.black,
            ),
          ],
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
