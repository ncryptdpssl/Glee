import 'package:flutter/material.dart';
import 'package:glee/musicWid//screens/details.dart';
import 'package:glee/musicWid//screens/home.dart';
import 'package:glee/musicWid//screens/search.dart';
import 'package:glee/musicWid//screens/loading.dart';
import 'package:glee/musicWid//screens/user_songs.dart';

void music() => runApp(Music());

class Music extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Main App
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music',
      theme: ThemeData(
        primaryColor: Color(0xFF3bd6c6),
        accentColor: Color(0xFF3bd6c6),
        backgroundColor: Colors.white,
        // Colors for various widgets
        cardColor: Color(0xFFf2f2f2),
        buttonColor: Color(0xFF3bd6c6),
      ),
      // Routes for the app
      routes: {
        '/': (context) => LoadingScreen(),
        '/home': (context) => HomeScreen(),
        '/user_songs': (context) => UserSongsScreen(),
        '/search': (context) => SearchScreen(),
        '/details': (context) => DetailsScreen(),
      },
      // default route
      initialRoute: '/',
    );
  }
}
