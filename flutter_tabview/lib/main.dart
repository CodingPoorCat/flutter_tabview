import 'package:flutter/material.dart';
import 'buttomTab.dart';
void main() => runApp(new DemoApp());

class DemoApp extends StatelessWidget {
  Widget build(BuildContext context){
    return MaterialApp(
        routes: <String,WidgetBuilder>{
          '/': (BuildContext context) => new Home(),
        },
        title : 'Brick',
        color: Color(0XFFF2F2F2),
      );
  }
}