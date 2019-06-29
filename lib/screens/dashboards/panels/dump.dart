import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DumpWidget extends StatefulWidget {
  final String urlPostfix = "/dump";
  final double width, height;
  final double offsetX, offsetY;
  final String url;

  DumpWidget({
    Key key,
    this.width = 50.0,
    this.height = 50.0,
    this.offsetX = 80.0,
    this.offsetY = 80.0,
    @required this.url,
  }) : super(key: key);

  @override
  _DumpState createState() => _DumpState();
}

class _DumpState extends State<DumpWidget> {
  String data = "None";
  Timer timer;
  Offset offset;

  Future<String> getRequest(String uri) async {
    try {
      var response = await http.get(uri);
      print(response.body);
      var parsed = json.decode(response.body);
      return parsed["data"];
    } catch (e) {
      print(e);
      return "None";
    }
  }

  @override
  void initState() {
    super.initState();
    offset = Offset(widget.width, widget.height);
    var _duration = Duration(seconds: 5);
    timer = Timer.periodic(_duration, (Timer t) async {
      String fullUrl = widget.url + widget.urlPostfix;
      print('FullUrl: $fullUrl');
      var _status = await getRequest(fullUrl);
      setState(() {
        data = _status;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          var newDxOffset = offset.dx + details.delta.dx;
          var newDyOffset = offset.dy + details.delta.dy;
          print("Dump Dx: $newDxOffset Dy: $newDyOffset");
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
          print("Dump Real Width: $width, Height: $height");
          if ((0 < newDxOffset && newDxOffset < width - widget.width) &&
              (0 < newDyOffset && newDyOffset < height - widget.height)) {
            setState(() {
              offset = Offset(newDxOffset, newDyOffset);
            });
          }
        },
        child: Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          decoration: new BoxDecoration(
              border: new Border.all(color: Colors.blueAccent)),
          child: new Text(data),
        ),
      ),
    );
  }
}
