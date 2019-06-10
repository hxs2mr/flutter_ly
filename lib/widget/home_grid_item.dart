import 'package:flutter/material.dart';
import 'package:hxsly_app/model/gridnav_model.dart';

class HomeGridItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }

  final String name;
  final GridNavModel homeGridModel;
  const HomeGridItem({Key key, @required this.homeGridModel, this.name = '首页'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  new Text('首页');
  }
}

class _HomeGriditemState extends State<HomeGridItem>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}