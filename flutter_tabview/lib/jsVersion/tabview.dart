import 'package:flutter/material.dart';
import 'tabbar.dart';

class MyTabview extends StatefulWidget {
  final NewsTab currentTab;
  final List<Widget> pages;
  MyTabview({
    Key key,
    this.currentTab,
    this.pages
  }):super(key:key);
  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return MyTabviewState();
    }
}
class MyTabviewState extends State<MyTabview>{
  NewsTab _currenttab = NewsTabs[0];
  void _selectTab(NewsTab tab){
    setState(() {
          _currenttab = tab;
        });
  }
  Widget build(BuildContext ctx){
    return Column(
      children: <Widget>[
        TabNavigation(
          currentTab: _currenttab,
          onSelectTab: _selectTab,
        ),
        Expanded(
          child:Stack(
            // fit属性决定了children的大小属性，默认是StackFit.loose尽可能小
            fit: StackFit.expand,
            children: NewsTabs.map((tab){
              return Offstage(
                offstage: _currenttab!=tab,
                child: Container(
                  alignment: Alignment.center,
                  child:Text(tab.text)
                ) ,
              );
            }).toList()
          )
        )
      ],
    );
  }
}