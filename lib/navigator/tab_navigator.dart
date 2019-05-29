import 'package:flutter/material.dart';
import 'package:hxsly_app/pages/home/Home_page.dart';
import 'package:hxsly_app/pages/ly/Ly_page.dart';
import 'package:hxsly_app/pages/my/My_page.dart';
import 'package:hxsly_app/pages/searh/Search_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  TabNavigatorState createState() => TabNavigatorState();
}

class TabNavigatorState extends State<TabNavigator> {
  final _nomorColor = Colors.grey;
  final _selectColor = Colors.deepOrange;
  int _currentindex = 0 ;
  //用于控制器  初始化为第一页
  final PageController _controller = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: PageView(
        onPageChanged: (index)
        {
          setState(() {
            _currentindex = index;
          });
        },
        controller: _controller,
        children: <Widget>[
          new HomePage(),
          new SearchPage(),
          new LyPage(),
          new MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentindex,
          onTap: (index){ 
            _controller.jumpToPage(index);
          setState(() {
            _currentindex = index;
          });
          },
          items: [
        BottomNavigationBarItem(
            icon: new Icon(Icons.home, color: _nomorColor,),
            activeIcon: new Icon(Icons.home, color: _selectColor,),
            title: Text('首页',style: TextStyle(color: _currentindex!=0?_nomorColor:_selectColor ),)
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.search,color: _nomorColor),
          activeIcon: new Icon(Icons.search,color: _selectColor,),
          title: Text('发现',style: TextStyle(color: _currentindex!=1?_nomorColor:_selectColor),)

        ),
        BottomNavigationBarItem(
            icon: new Icon(Icons.camera_alt,color: _nomorColor),
            activeIcon: new Icon(Icons.camera_alt,color: _selectColor,),
            title: Text('路照',style: TextStyle(color: _currentindex!=2?_nomorColor:_selectColor),)
        ),
        BottomNavigationBarItem(
            icon: new Icon(Icons.person_pin,color: _nomorColor),
            activeIcon: new Icon(Icons.person_pin,color: _selectColor,),
            title: Text('我的',style: TextStyle(color: _currentindex!=3?_nomorColor:_selectColor),)
        ),
      ]),
    );
  }
}
