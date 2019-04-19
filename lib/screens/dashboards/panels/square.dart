import 'package:flutter/material.dart';

class SquareWidget extends StatefulWidget {
  final double width, height;
  final double offsetX, offsetY;

  SquareWidget({
    Key key,
    this.width = 100.0,
    this.height = 100.0,
    this.offsetX = 20.0,
    this.offsetY = 20.0,
  }) : super(key: key);

  @override
  _SquareState createState() => _SquareState();
}

class _SquareState extends State<SquareWidget> {
  Offset offset;

  @override
  void initState() {
    super.initState();
    offset = Offset(widget.width, widget.height);
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
          print("Square Dx: $newDxOffset Dy: $newDyOffset");
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
          print("Square Real Width: $width, Height: $height");
          if ((0 < newDxOffset && newDxOffset < width - widget.width) &&
              (0 < newDyOffset && newDyOffset < height - widget.height)) {
            setState(() {
              offset = Offset(newDxOffset, newDyOffset);
            });
          }
        },
        child: Container(
          width: 100,
          height: 100,
          color: Colors.red,
        ),
      ),
    );
  }
}
