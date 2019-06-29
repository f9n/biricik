import 'dart:async';

import 'package:flutter/material.dart';

import 'package:biricik/helpers/requests.dart';

class DistanceWidget extends StatefulWidget {
  final String urlPostfix = "/distance";
  final double width, height;
  final double offsetX, offsetY;
  final String url;

  DistanceWidget({
    Key key,
    this.width = 50.0,
    this.height = 50.0,
    this.offsetX = 80.0,
    this.offsetY = 80.0,
    @required this.url,
  }) : super(key: key);

  @override
  _DistanceState createState() => _DistanceState();
}

class _DistanceState extends State<DistanceWidget> {
  String data = "None";
  Timer timer;
  Offset offset;

  @override
  void initState() {
    super.initState();
    offset = Offset(widget.width, widget.height);
    var _duration = Duration(seconds: 5);
    timer = Timer.periodic(_duration, (Timer t) async {
      String fullUrl = widget.url + widget.urlPostfix;
      print('FullUrl: $fullUrl');
      var _status = await getDistance(fullUrl);
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
          print("Distance Dx: $newDxOffset Dy: $newDyOffset");
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
          print("Distance Real Width: $width, Height: $height");
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
            border: new Border.all(
              color: Colors.blueAccent,
            ),
          ),
          child: new Text(data),
        ),
      ),
    );
  }
}
