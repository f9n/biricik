import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovementWidget extends StatefulWidget {
  final double width, height;
  final double offsetX, offsetY;
  final String url;

  MovementWidget({
    Key key,
    this.width = 180.0,
    this.height = 180.0,
    this.offsetX = 150.0,
    this.offsetY = 150.0,
    @required this.url,
  }) : super(key: key);

  @override
  _MovementState createState() => _MovementState();
}

// TODO: Refactor
class _MovementState extends State<MovementWidget> {
  Offset offset;

  @override
  void initState() {
    super.initState();
    offset = Offset(widget.offsetX, widget.offsetY);
  }

  @override
  Widget build(BuildContext context) {
    double widthOfOneBox = widget.width / 3;
    double heightOfOneBox = widget.height / 3;

    return Positioned(
      width: widget.width,
      height: widget.height,
      left: offset.dx,
      top: offset.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          var newDxOffset = offset.dx + details.delta.dx;
          var newDyOffset = offset.dy + details.delta.dy;
          print("Movement Dx: $newDxOffset Dy: $newDyOffset");
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
          print("Movement Real Width: $width, Height: $height");
          // Dx 0 dan kucuk olamaz.
          // Dx En yuksek enlik - widget'in genisliginden buyuk olamaaz.
          // Dy 0 dan kucuk olamaz.
          // Dy En yuksek boy - widget'in boyundan buyuk olamaz. Appbar height'i da cikarman lazim.
          if ((0 < newDxOffset && newDxOffset < width - widget.width) &&
              (0 < newDyOffset && newDyOffset < height - widget.height)) {
            setState(() {
              offset = Offset(newDxOffset, newDyOffset);
            });
          }
        },
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: widthOfOneBox,
                  height: heightOfOneBox,
                ),
                SizedBox(
                  width: widthOfOneBox,
                  height: heightOfOneBox,
                  child: _genericMovementButton("up"),
                ),
                SizedBox(
                  width: widthOfOneBox,
                  height: heightOfOneBox,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: widthOfOneBox,
                  height: heightOfOneBox,
                  child: _genericMovementButton("left"),
                ),
                SizedBox(
                  width: widthOfOneBox,
                  height: heightOfOneBox,
                ),
                SizedBox(
                  width: widthOfOneBox,
                  height: heightOfOneBox,
                  child: _genericMovementButton("right"),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: widthOfOneBox,
                  height: heightOfOneBox,
                ),
                SizedBox(
                  width: widthOfOneBox,
                  height: heightOfOneBox,
                  child: _genericMovementButton("down"),
                ),
                SizedBox(
                  width: widthOfOneBox,
                  height: heightOfOneBox,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _genericMovementButton(String type) {
    IconData icon;
    String action;
    switch (type) {
      case "up":
        icon = Icons.arrow_upward;
        action = "forward";
        break;
      case "down":
        icon = Icons.arrow_downward;
        action = "backward";
        break;
      case "left":
        icon = Icons.arrow_back;
        action = type;
        break;
      case "right":
        icon = Icons.arrow_forward;
        action = type;
        break;
      default:
    }
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: go(action),
      child: Icon(icon),
    );
  }

  Function go(String status) {
    return () {
      if ([
        "forward",
        "backward",
        "left",
        "right",
      ].contains(status)) {
        var url = "${widget.url}/$status";
        print(url);
        /*
        http.get(url).then((res) {
          print("Response status: ${res.statusCode}");
          print("Response body: ${res.body}");
        });
        */
      }
    };
  }
}
