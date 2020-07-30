import 'package:flutter/material.dart';
import 'package:glee/meditation//screens/breathe_screen.dart';
import 'package:glee/meditation//screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:glee/meditation//state/settings.dart';


void chat() => runApp(MED());

class MED extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Settings>(
      builder: (context) => Settings(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'breathing',
        theme: ThemeData(),
        initialRoute: SettingsScreen.id,
        routes: {
          SettingsScreen.id: (context) => SettingsScreen(),
          BreatheScreen.id: (context) => BreatheScreen(),
        },
      ),
    );
  }
}
