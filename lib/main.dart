import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glee/community/chat.dart';
import 'package:glee/diary/diary.dart';
import 'package:glee/meditation/med.dart';
import 'package:glee/musicWid/music.dart';
import 'package:glee/screens/chatbot.dart';
import 'package:glee/screens/draw.dart';
import 'package:glee/widgets/category_card.dart';

void main() => runApp(Glee());

class Glee extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GLEE',
      theme: ThemeData(
        fontFamily: "Cairo",
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
        textTheme: Theme.of(context).textTheme.apply(displayColor: Color(0xFF222B45)),
      ),
      home: Home(
      ),

      );
  }
}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
      drawer:Drawer(
        child: Container(
          color: Color(0xFF3bd6c6),
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Rest!",
                  style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.black
                  ),),
                accountEmail: null,
                decoration: BoxDecoration(
                  color: Color(0xFF40e0d0),
                ),
              ),
              ListTile(
                title: Text("Know More",
                  style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white
                  ),
                ),
                onTap: (){
                  Navigator.of(context).pop();
                },
                leading: Icon(Icons.tag_faces,color: Colors.purpleAccent,size: 22.0,),
              ),
              ListTile(
                title: Text("Sign Out",
                  style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white
                  ),
                ),
                onTap: (){
                  Navigator.of(context).pop();
                },
                leading: Icon(Icons.power_settings_new,color: Colors.red,size: 22.0,),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset('assets/Glee/logo-01.png'),
                  Text(
                    "Welcome to GLEE - ",
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)
                  ),
                  Text(
                    "It's time to relax and rejuvenate~",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),
                  ),
                  SizedBox(height: 30,),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        CategoryCard(
                          title: "Music",
                          svgSrc: "assets/Glee/music.svg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return Music();
                              }),
                            );
                          },
                        ),
                        CategoryCard(
                          title: "Meditation",
                          svgSrc: "assets/Glee/meditation-1.svg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return MED();
                              }),
                            );
                          },
                        ),
                        CategoryCard(
                          title: "Let's Chat",
                          svgSrc: "assets/Glee/chat.svg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return ChatBot();
                              }),
                            );
                          },
                        ),
                        CategoryCard(
                          title: "Community",
                          svgSrc: "assets/Glee/community-1.svg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return Community();
                              }),
                            );
                          },
                        ),
                        CategoryCard(
                          title: "Draw",
                          svgSrc: "assets/Glee/draw.svg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return app1();
                              }),
                            );
                          },
                        ),
                        CategoryCard(
                          title: "Diary",
                          svgSrc: "assets/Glee/notes.svg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return Diary();
                              }),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
