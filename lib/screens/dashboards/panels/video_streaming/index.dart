import 'package:flutter/material.dart';
import './video_streaming_with_webview.dart';

class VideoStreamingWidget extends StatefulWidget {
  @override
  _VideoStreamingWidgetState createState() => _VideoStreamingWidgetState();
}

class _VideoStreamingWidgetState extends State<VideoStreamingWidget> {
  Offset offset = Offset(200, 200);

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
        child: VideoStreamingWithWebView(),
      ),
    );
  }
}
