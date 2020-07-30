import 'package:flutter/material.dart';
import 'package:glee/community/screens/welcome_screen.dart';
import 'package:glee/community/screens/login_screen.dart';
import 'package:glee/community/screens/registration_screen.dart';
import 'package:glee/community/screens/chat_screen.dart';

void chat() => runApp(Community());

class Community extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
