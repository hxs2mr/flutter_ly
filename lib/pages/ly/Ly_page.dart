//作者: HXS
//创建时间:2019/5/17
// 版本号: 1.0
//功能描述 :
import 'package:flutter/material.dart';

    var CITY_NAMES =['北京','上海','广州','深圳','杭州','习水','温水','重庆','长沙','湖北','武汉','日本','英国','美国'];
class LyPage extends StatefulWidget {
  @override
  LyPageState createState() => new LyPageState();
}

class LyPageState extends State<LyPage> {
  ScrollController _scrollController = new ScrollController();

  //生命周期开始
  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent)//是否是最大滚动的位置   触发加载更多
        {
          _LoadMoreData();
        }
    });
    super.initState();
  }
  //生命周期结束
  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child:new Container(
        child: RefreshIndicator(
         onRefresh: _handleRefresh,
          child:  new GridView.count(
            controller: _scrollController,
            crossAxisCount: 2,
            children: _buildList(),
          )),
        )
      ) ;
  }
  List<Widget> _buildList() {
    return   CITY_NAMES.map((city) => _item(city)).toList();
  }
  Widget _item(String city)
    {
      return new Container(
        width: 160,
        margin: EdgeInsets.only(right: 5,bottom: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.teal),
        child: new Text(city,style: new TextStyle(color: Colors.white,fontSize: 22),),
      );
  }

  Future<Null> _handleRefresh() async{
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      CITY_NAMES = CITY_NAMES.reversed.toList();
    });
    return null;
    }
  _LoadMoreData() async{
    await Future.delayed(Duration(microseconds: 200));
    setState(() {
      List<String> list = List<String>.from(CITY_NAMES);
      list.addAll(CITY_NAMES);
      CITY_NAMES = list;
    });
  }
}