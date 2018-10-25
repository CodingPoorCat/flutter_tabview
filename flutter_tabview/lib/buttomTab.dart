import 'package:flutter/material.dart';
import './flutterVersion/first.dart';
import './jsVersion/second.dart';
import './jsBetterVersion/third.dart';
class Home extends StatefulWidget {
  State<StatefulWidget> createState(){
    return _HomeState();
  }
}

class _HomeState extends State<Home>{
  int _currentindex = 0;
  Widget build(BuildContext context){
    final List<Widget> _navigationPages = 
    [
      new First(),
      new Second(),
      new Third()];
    void onTabTapped(int index){
      setState(() {
          this._currentindex = index;
        });
    }
    return Scaffold(
      body: _navigationPages[_currentindex],
      bottomNavigationBar : BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentindex,
        items : [
          BottomNavigationBarItem(
           icon: new Icon(Icons.home),
           title: new Text('first'),
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.mail),
           title: new Text('second'),
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.person),
           title: Text('third')
         )
        ]
      )
    );
  }
}