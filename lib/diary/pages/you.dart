import 'package:flutter/material.dart';
import 'notifications.dart';
import 'settings.dart';

class Personal extends StatefulWidget {
  @override
  _PersonalState createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("You"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(title: Text("Settings", textAlign: TextAlign.center,), onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));},),
          Divider(),
          ListTile(title: Text("Notifications", textAlign: TextAlign.center,), onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications()));}),
          Divider(),
        ],
      )
    );
  }
}