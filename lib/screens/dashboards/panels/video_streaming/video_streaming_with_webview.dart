import 'dart:async';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:biricik/db/dbHelper.dart';
import 'package:biricik/models/resource.dart';

class VideoStreamingWithWebView extends StatelessWidget {
  DbHelper dbHelper = new DbHelper();
  SharedPreferences sharedPreferences;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  final double width;
  final double height;

  VideoStreamingWithWebView({this.width: 200.0, this.height: 200.0});

  Future<Resource> _getResource() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var defaultResourceId = sharedPreferences.getInt('defaultResourceId');
    return dbHelper.getResourceById(defaultResourceId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width + 5.0,
      height: height + 5.0,
      child: FutureBuilder<Resource>(
        future: _getResource(),
        builder: (BuildContext context, AsyncSnapshot<Resource> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');

              print("Snapshot Data => ${snapshot.data}");
              var initialUrl =
                  "${snapshot.data.url}/stream?width=${width}&height=${height}";
              return WebView(
                initialUrl: initialUrl,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
              );
          }
        },
      ),
    );
  }
}
