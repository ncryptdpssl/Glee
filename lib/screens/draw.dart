import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void draw()
{
  runApp(app1());
}
class app1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Draw",home: app2(),);
  }
}

class app2 extends StatefulWidget {
  @override
  _app2State createState() => _app2State();
}

class _app2State extends State<app2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Url"),),body:
      RaisedButton(child: Text("Click To Draw"),onPressed: (){openurl();} ,),

    );
  }
  openurl()
  {
    String Url = "https://gleepaint.herokuapp.com/";
    launch(Url);
  }
}
