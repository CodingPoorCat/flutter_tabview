import 'package:flutter/material.dart';
// 开发参考
// 作者：燃烧的鱼丸
// 链接：https://juejin.im/post/5bb50397f265da0abe270f25
// 来源：掘金


class NewsTab {
  String text;
  String tabid;
  NewsTab(this.text,this.tabid);
}
//定义tab页基本数据结构
final List<NewsTab> NewsTabs = <NewsTab>[
  new NewsTab('金融','financial'),
  new NewsTab('科技','technology'),
  new NewsTab('医疗','medical'),
];

class TabNavigation extends StatelessWidget {
  TabNavigation({this.currentTab, this.onSelectTab});
  // 以下两个参数由父组件传入并由父组件管理相关状态
  // 参考react的组件开发
  final NewsTab currentTab;
  // TODO
  // ValueChanged的作用是？
  final ValueChanged<NewsTab> onSelectTab;  //这个参数比较关键，仔细理解下，省了setState()调用的环节

  @override
  Widget build(BuildContext context) {
    return Row(
      children: NewsTabs.map((item){
        // 此处使用Expanded，但是当tab页超级多时，会压缩到看不到，应该有isScroll来管理是否使用Expaned
        // TODO:增加可控参数isScroll
        return Expanded(
          child: InkWell(
            onTap:()=>onSelectTab(item,),
            child:Container(
              height: 40.0,
              padding: EdgeInsets.all(5.0),
                alignment: Alignment.center,
                child:Text(item.text,style: TextStyle(color:_colorTabMatching(item:item)))
              )
        ));
      }    
    ).toList());
  }
  Color _colorTabMatching({NewsTab item}) {
    return currentTab == item ? Colors.black : Colors.grey;
  }
}
