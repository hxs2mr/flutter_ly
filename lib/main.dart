import 'package:flutter/material.dart';
import 'package:hxsly_app/HeroDemo.dart';
import 'package:hxsly_app/animdemo.dart';
import 'package:hxsly_app/navigator/tab_navigator.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: '',
      theme: ThemeData(
        primaryColor: Colors.cyan,
      ),
      home: TabNavigator()
    );
  }
}
