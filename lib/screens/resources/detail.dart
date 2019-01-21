import 'package:flutter/material.dart';
import 'package:biricik/db/dbHelper.dart';
import 'package:biricik/models/resource.dart';

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
        actions: <Widget>[
          PopupMenuButton<Choice>(
            onSelected: select,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Choice>>[
                  PopupMenuItem<Choice>(
                    value: Choice.Delete,
                    child: Text("Delete resource"),
                  ),
                  PopupMenuItem<Choice>(
                    value: Choice.Update,
                    child: Text("Update resource"),
                  ),
                ],
          ),
        ],
      ),
      body: Center(
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.shop),
                title: Text(widget.resource.name),
                subtitle: Text(widget.resource.description),
              ),
              Text("${widget.resource.name} url is ${widget.resource.url}"),
            ],
          ),
        ),
      ),
    );
  }

  void select(Choice choice) async {
    int result;
    switch (choice) {
      case Choice.Delete:
        Navigator.pop(context, true);
        result = await dbHelper.delete(widget.resource.id);
        if (result != 0) {
          AlertDialog alertDialog = new AlertDialog(
            title: Text("Success"),
            content: Text("Deleted resource: ${widget.resource.name}"),
          );
          showDialog(context: context, builder: (_) => alertDialog);
        }
        break;
      case Choice.Update:
        break;
      default:
    }
  }
}
