import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoStreamingWithWebView extends StatelessWidget {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  final double width;
  final double height;

  VideoStreamingWithWebView({this.width: 200.0, this.height: 200.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width + 5.0,
      height: height + 5.0,
      child: WebView(
        initialUrl:
            "http://192.168.1.101:8080/stream?width=${width}&height=${height}",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
