import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';

class Uv4lCameraConfigurationScreen extends StatefulWidget {
  final String name;
  final String url;
  final String path;

  Uv4lCameraConfigurationScreen({
    @required this.name,
    @required this.url,
    this.path: "/api/videodev/settings",
  });

  @override
  _Uv4lCameraConfigurationScreenState createState() =>
      _Uv4lCameraConfigurationScreenState();
}

class _Uv4lCameraConfigurationScreenState
    extends State<Uv4lCameraConfigurationScreen> {
  var availableFormats;
  var controls;
  var currentFormat;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future _fetchConfigurations() async {
    final response = await http.get("${widget.url}${widget.path}");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load configurations');
    }
  }

  _getData() async {
    var _configurations = await _fetchConfigurations();
    /*var _configurations = {
      'available_formats': [],
      'controls': [],
      'current_format': {
        'width': 500,
        'height': 500,
      },
    };
    */
    setState(() {
      availableFormats = _configurations['available_formats'];
      controls = _configurations['controls'];
      currentFormat = _configurations['current_format'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.name} - Camera Configuration'),
      ),
      body: Container(),
    );
  }
}

/**
 * Container(
        margin: EdgeInsets.all(15.0),
        child: FormBuilder(
          context,
          autovalidate: true,
          showResetButton: true,
          // resetButtonContent: Text("Clear Form"),
          controls: [
            FormBuilderInput.number(
              value: currentFormat['width'],
              attribute: "width",
              label: "Width",
              require: true,
              min: 64,
            ),
            FormBuilderInput.number(
              value: currentFormat['height'],
              attribute: "height",
              label: "Height",
              require: true,
              min: 64,
            ),
          ],
          onChanged: (formValue) {
            print(formValue);
          },
          onSubmit: (formValue) {
            if (formValue != null) {
              print(formValue);
              // Http PUT request
            } else {
              print("Form invalid");
            }
          },
        ),
      ),
 */
