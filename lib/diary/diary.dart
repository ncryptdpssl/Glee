import 'package:glee/diary/pages/home.dart';
import 'package:glee/diary/pages/timeline.dart';
import 'package:glee/diary//pages/you.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';


class Diary extends StatefulWidget {
  @override
  _DiaryState createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  Brightness brightness;

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) =>
          ThemeData(primarySwatch: Colors.teal, brightness: brightness),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Widget> _pages = [Home(), Timeline(), Personal()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.bubble_chart,
                size: 0,
              ),
              title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.timelapse,
                size: 0,
              ),
              title: Text("Timeline")),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 0,
              ),
              title: Text("Personal"))
        ],
      ),
    );
  }
}
