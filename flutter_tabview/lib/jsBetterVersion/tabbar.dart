import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';
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
  new NewsTab('英雄联盟','英雄联盟'),
  new NewsTab('王者荣耀','王者荣耀'),
  new NewsTab('Dota2','Dota2'),
  new NewsTab('守望先锋','守望先锋'),
  new NewsTab('绝地求生','绝地求生'),
  new NewsTab('CS:GO','CS:GO'),
  new NewsTab('彩虹6号','彩虹6号'),
  new NewsTab('魔兽争霸','魔兽争霸'),
  new NewsTab('风暴英雄','风暴英雄'),
];

class TabNavigation extends StatefulWidget {
  TabNavigation({
    this.currentTab, 
    this.onSelectTab,
    this.isScrollable:true}
  );
  // 以下两个参数由父组件传入并由父组件管理相关状态
  // 参考react的组件开发
  final NewsTab currentTab;
  final bool isScrollable;
  // TODO
  // ValueChanged的作用是？
  final ValueChanged<NewsTab> onSelectTab;  //这个参数比较关键，仔细理解下，省了setState()调用的环节

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return _TabNavigationState();
    }
}

class _TabNavigationState extends State<TabNavigation>{
  ScrollController controller = new ScrollController();
  List<double> xOffsets = <double>[];
  int currentIndex = 0;
  double currentPosition = 0.0;
  double deviceSize =0.0;
  @override
  Widget build(BuildContext context) {
    List<Widget> _renderTabs = [];
   deviceSize =  MediaQuery.of(context).size.width;
    for(var i = 0;i<NewsTabs.length;i++){
      _renderTabs.add(
          Ink(
            //必须包裹一层Ink，设置Ink的背景颜色才行
            color: Colors.blue,
            child:InkWell(
                onTap:(){_handleTap(NewsTabs[i],i);},
                child:Container(
                  // 在Container设置背景颜色，会导致没有波纹效果
                  height: 50.0,
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    alignment: Alignment.center,
                    child:Text(NewsTabs[i].text,style: TextStyle(color:Colors.white,fontSize:_sizeTabMatching(item:NewsTabs[i])))
                  )
            )
          )
        );
        if(widget.isScrollable){
          _renderTabs[i] = Container(
            child: _renderTabs[i],
          );
        }else{
          _renderTabs[i] = Expanded(
            child: _renderTabs[i],
          );
        }
    }
    if(widget.isScrollable){
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller:controller,
        child: Container(
          child: _TabBar(
            onPerformLayout: _saveTabOffsets,
            children:_renderTabs
            ),
        ));
    }
    return Container(
      height: 50.0,
      child: _TabBar(
        onPerformLayout: _saveTabOffsets,
        children:_renderTabs
        ),
    );
  }
  double _sizeTabMatching({NewsTab item}) {
    return widget.currentTab == item ? 16.0 : 12.0;
  }

  @override
    void didUpdateWidget(TabNavigation oldWidget) {
      // TODO: implement didUpdateWidget
      super.didUpdateWidget(oldWidget);

    }
  void _updateScroller(index){
    // 判断当前位置和要滚动的位置，决定滚动距离
    // 点击的tab项就是当前的tab项
    double moveDistance = 0.0;
    if(currentIndex == index){
      return;
    }
    if(xOffsets[index] > deviceSize/2){
      moveDistance = (xOffsets[index] - deviceSize/2)+(xOffsets[index+1]-xOffsets[index])/2;
    }
    // 计算点击的tab项要当前屏幕中心的距离
    controller.animateTo(moveDistance, duration: kTabScrollDuration, curve: Curves.ease);
    currentIndex = index;
    currentPosition = xOffsets[index];
  }
  void _handleTap(item,index){
    widget.onSelectTab(item,);
    _updateScroller(index);
  }
  // Called each time layout completes.
  void _saveTabOffsets(List<double> tabOffsets, TextDirection textDirection, double width) {
    xOffsets = tabOffsets;
  }
}




class _TabBar extends Flex {
  _TabBar({
    Key key,
    List<Widget> children = const <Widget>[],
    this.onPerformLayout
  }):super(
    children:children,
    direction: Axis.horizontal,
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    verticalDirection: VerticalDirection.down,
  );
  final _LayoutCallback onPerformLayout;

  @override
  RenderFlex createRenderObject(BuildContext context) {
      return _MyTabRenderer(
        onPerformLayout: onPerformLayout,
        direction: direction,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: getEffectiveTextDirection(context),
        verticalDirection: verticalDirection,
      );
  }
  // @override
  // void updateRenderObject(BuildContext context, _MyTabRenderer renderObject) {
  //   super.updateRenderObject(context, renderObject);
  //   renderObject.onPerformLayout = onPerformLayout;
  // }
}
class _MyTabRenderer extends RenderFlex {
    _MyTabRenderer({
      Key key,
      List<RenderBox> children,
      @required this.onPerformLayout,
      @required Axis direction,
      @required MainAxisSize mainAxisSize,
      @required MainAxisAlignment mainAxisAlignment,
      @required CrossAxisAlignment crossAxisAlignment,
      @required TextDirection textDirection,
      @required VerticalDirection verticalDirection,
    }): assert(onPerformLayout != null),
    super(
      children:children,
      textDirection:TextDirection.ltr
    );
    _LayoutCallback onPerformLayout;

    @override
  void performLayout() {
    super.performLayout();
    RenderBox child = firstChild;
    final List<double> xOffsets = <double>[];
    while (child != null) {
      final FlexParentData childParentData = child.parentData;
      xOffsets.add(childParentData.offset.dx);
      assert(child.parentData == childParentData);
      child = childParentData.nextSibling;
    }
    switch (textDirection) {
      case TextDirection.rtl:
        xOffsets.insert(0, size.width);
        break;
      case TextDirection.ltr:
        xOffsets.add(size.width);
        break;
    }
    onPerformLayout(xOffsets,textDirection,size.width);
    }

   
}
typedef _LayoutCallback = void Function(List<double> xOffsets, TextDirection textDirection, double width);


