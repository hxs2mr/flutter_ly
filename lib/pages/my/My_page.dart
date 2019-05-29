
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget
{
  @override
  MyPageState createState()=>MyPageState();
}
class MyPageState extends State<MyPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(

      body: new Center(
        child: new Text("我的"),
      ),
    );
  }
}