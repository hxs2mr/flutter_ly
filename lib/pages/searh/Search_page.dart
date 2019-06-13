//作者: HXS
//创建时间:2019/5/17
// 版本号: 1.0
//功能描述 :
import 'package:flutter/material.dart';
import 'package:hxsly_app/widget/search_bar.dart';
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
    return  new Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SearchBar(
            hideLeft: true,
            defaultText: '深圳',
            hint: '搜索',
            leftButtonClick: (){
              Navigator.pop(context);
            },
            onChanged: _onTextChange,
          ),
        ],
      ),
    );

  }
  _onTextChange(text){

  }
}