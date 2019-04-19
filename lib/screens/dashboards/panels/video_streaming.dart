import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoStreamingWidget extends StatefulWidget {
  final double width, height;
  final double offsetX, offsetY;
  final String url;

  VideoStreamingWidget({
    Key key,
    this.width = 100.0,
    this.height = 100.0,
    this.offsetX = 20.0,
    this.offsetY = 200.0,
    @required this.url,
  }) : super(key: key);

  @override
  _VideoStreamingWidgetState createState() => _VideoStreamingWidgetState();
}

class _VideoStreamingWidgetState extends State<VideoStreamingWidget> {
  Offset offset;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    offset = Offset(widget.width, widget.height);
  }

  @override
  Widget build(BuildContext context) {
    var initialUrl =
        "${widget.url}/stream?width=${widget.width}&height=${widget.height}";

    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          var newDxOffset = offset.dx + details.delta.dx;
          var newDyOffset = offset.dy + details.delta.dy;
          print("VideoStreaming Dx: $newDxOffset Dy: $newDyOffset");
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
          print("VideoStreaming Real Width: $width, Height: $height");
          if ((0 < newDxOffset && newDxOffset < width - widget.width) &&
              (0 < newDyOffset && newDyOffset < height - widget.height)) {
            setState(() {
              offset = Offset(newDxOffset, newDyOffset);
            });
          }
        },
        child: Container(
          child: WebView(
            initialUrl: initialUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
          ),
        ),
      ),
    );
  }
}
