import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Notifications'),
            trailing: Switch(
              value: true, // Placeholder for notification toggle
              onChanged: (value) {
                // Handle notification toggle
              },
            ),
          ),
          ListTile(
            title: Text('App Version'),
            subtitle: Text('1.0.0'), // Placeholder for app version
          ),
        ],
      ),
    );
  }
}
