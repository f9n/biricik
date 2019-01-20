import 'package:flutter/material.dart';

// import 'package:biricik/domain/settings.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  /* static Settings settings = Settings.getInstance();

  communicationSelector() {
    return ListTile(
      title: Text('Communication Type'),
      subtitle: Text('Define the communication type'),
      trailing: DropdownButton(
        items: [
          DropdownMenuItem(
              value: Communication.bluetooth, child: Text('Bluetooth')),
          DropdownMenuItem(value: Communication.wifi, child: Text('Wifi')),
        ],
        value: settings.communication,
        onChanged: (value) => setState(() => settings.communication = value),
      ),
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: <Widget>[
          Text('Default Resource'),
          Divider(),
        ],
      ),
    );
  }
}
