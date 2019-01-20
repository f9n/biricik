import 'package:flutter/material.dart';

class SquareWidget extends StatefulWidget {
  @override
  _SquareState createState() => _SquareState();
}

class _SquareState extends State<SquareWidget> {
  Offset offset = Offset(100, 100);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          var newDxOffset = offset.dx + details.delta.dx;
          var newDyOffset = offset.dy + details.delta.dy;
          print("Dx: $newDxOffset Dy: $newDyOffset");
          setState(() {
            offset = Offset(newDxOffset, newDyOffset);
          });
        },
        child: Container(width: 100, height: 100, color: Colors.red),
      ),
    );
  }
}
