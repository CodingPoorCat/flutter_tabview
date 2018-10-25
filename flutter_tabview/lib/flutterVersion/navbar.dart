import "package:flutter/material.dart";
class Navbar extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return NavbarState();
    }
}

class NavbarState extends State<Navbar> with SingleTickerProviderStateMixin{
   TabController _tabController;
   final List<Map> channelList = [
     {
       "id":'0',
       "name":'英雄联盟'
     },
     {
       "id":'1',
       "name":'守望先锋'
     }, 
     {
       "id":'2',
       "name":'风暴英雄'
     },
     {
       "id":'3',
       "name":'CSGO'
     },
     {
       "id":'4',
       "name":'Dota2'
     },
     {
       "id":'0',
       "name":'英雄联盟'
     },
     {
       "id":'1',
       "name":'守望先锋'
     }, 
     {
       "id":'2',
       "name":'风暴英雄'
     },
     {
       "id":'3',
       "name":'CSGO'
     },
     {
       "id":'4',
       "name":'Dota2'
     },
   ];
  List<Tab> tabs;
  List<Widget> recommends = [];
  void initState(){
    super.initState();
    tabs = channelList.map((Map tab){
      return new Tab(text:tab['name']);
    }).toList();
    _tabController = TabController(vsync: this, length: tabs.length);
  }
  Widget build(BuildContext ctx){
    return
      Column(children:<Widget>[
        Material(
          color:Colors.blue,
          // 阴影颜色
          shadowColor: Colors.black,
          // 阴影大小和顺序
          elevation:5.0,
          child: TabBar(
            // 是否可滚动
            isScrollable: tabs.length>5,
            //指示器颜色
            indicatorColor:Colors.white,
            //选中标签的文字颜色
            labelColor: Colors.white,
            //选中标签的文字样式
            labelStyle: TextStyle(fontSize:14.0),
            //未选中时tab的文字颜色
            unselectedLabelColor:Colors.white,
            //未选中时tab的文字样式
            unselectedLabelStyle:TextStyle(fontSize:12.0),
            tabs: tabs,
            controller: _tabController,
          )
        ),
        Expanded(
          child:TabBarView(
            controller:_tabController,
            children: tabs,
          )
        )
      ])
      ;
  }
}