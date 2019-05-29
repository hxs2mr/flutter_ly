
import 'package:flutter/material.dart';
class animDemoApp extends StatefulWidget{
  @override
  AnimState createState()  => new AnimState();

}

class LogoWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: new FlutterLogo(),
    );
  }
}
class GrowTransition extends StatelessWidget {
  GrowTransition({this.child,this.animation});
  final Widget child;
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context,child)=>new Container(
        height: animation.value,
        width: animation.value,
        child: child,
      ),
      child: child,
    );
  }
}


class AnimLogo extends AnimatedWidget{
  AnimLogo({Key key,Animation<double> animation}):super(key:key,listenable:animation);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final Animation<double> animation = listenable;
    return  new Center(
      child: new Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        height: animation.value,
        width: animation.value,
        child: new FlutterLogo(),
      ),
    );
  }
}

class AnimState extends State<animDemoApp> with SingleTickerProviderStateMixin
{
  Animation<double> animation;
  AnimationController animationController;

  double animvaule;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //用于时间等控制
    animationController = AnimationController(vsync: this,duration: new Duration(seconds: 5));
    //begin其实的animation.value开始的值  end:表示结束的值
    animation = Tween<double>(begin: 100,end: 500).animate(animationController);
    animationController.reset();
    animationController.forward();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  new Container(
      margin: EdgeInsets.only(top: 50),
      child:  GrowTransition(animation: animation,child: LogoWidget())
    );
  }
}