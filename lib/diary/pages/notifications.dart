import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'add.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    final settingsAndroid = new AndroidInitializationSettings('dream_journal_shape');
    final settingsIOS = new IOSInitializationSettings(onDidReceiveLocalNotification: (id, title, body, payload) => onSelectNotification(payload));
    notifications.initialize(InitializationSettings(settingsAndroid, settingsIOS,), onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async => await Navigator.push(context, MaterialPageRoute(builder: (context) => Add()));

  var setTime;
  String text;
  static var androidPlatformChannelSpecifics = new AndroidNotificationDetails('daily channel id', 'daily channel name', 'daily channel description');
  static var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  

  @override
  Widget build(BuildContext context) {
    text = "Set a Reminder";
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Notifications"),
      ),
      body: ListView(
        children: <Widget>[
          Divider(),
          FlatButton(
            child: Text(text),
            onPressed: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              setTime = new Time(time.hour, time.minute, 0);
              print(time.hour.toString());
            },
          ),
          Divider(),
          FlatButton(
            onPressed: () async {
              await notifications.showDailyAtTime(0, "Add entry", "It's time to relax and release your emitions", setTime, platformChannelSpecifics);
            },
            child: Text("Send me a Reminder"),
          )
        ],
      )
    );
  }
}