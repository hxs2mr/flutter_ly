//作者: HXS
//创建时间:2019/5/17
// 版本号: 1.0
//功能描述 :
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() => new SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  String   countString ="";
  String   count="";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('搜索'),
        ),
        body: new Center(
            child: new Column(
              children: <Widget>[
                new RaisedButton(
                    onPressed:_inaddCounter,
                  child: new Text("添加数据"),
                    ),
                new RaisedButton(onPressed: _getCounter,
                child: new Text('获取数据'),),
                new Text(countString),
                new Text(count),
              ],
            ),

        )
      ),
    );
  }


  _inaddCounter()async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      setState(() {
        countString=countString+"1";
      });
      int counter =(sp.getInt('counter')??0)+1;
     await  sp.setInt('counter', counter);
  }

   _getCounter() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      count = sp.getInt('counter').toString();
    });
   }
}