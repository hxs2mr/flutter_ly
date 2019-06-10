

///hero动画
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;



class HeroDemoApp extends StatelessWidget {

  const HeroDemoApp({Key key, this.image, this.onTop, this.width}) : super(key: key);
  final String image;
  final VoidCallback onTop;
  final double width;
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: width,
      //tag动画之间连接的关联   连接的ID
      child: new Hero(tag: image, child:new Material(
        child:Material(
          color: Colors.transparent,
        child:InkWell(
          onTap: onTop,
          child:new Container(
            width: width,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.purple
              ),
              color: Colors.lightBlue,
              borderRadius: new BorderRadius.circular(width/2),
              image: DecorationImage(image: ExactAssetImage(image)),
            ),
            child:new Image.network(image,fit: BoxFit.contain,) ,
          ),
        ),
        ),

      ) ),
    );
  } 
}

class  HeroAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0;
    return new  Scaffold(
      appBar: new AppBar(
        title: new Text('Hero动画'),
      ),
      body: new Center(
        child: HeroDemoApp(image:"http://b-ssl.duitang.com/uploads/item/201603/05/20160305133057_MSNEv.jpeg" ,
          width:300 ,
          onTop:(){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return Scaffold(
              appBar: new AppBar(
                title: new Text("第二页"),
              ),
              body: new Container(
                margin:EdgeInsets.only(left: 100),
                color: Colors.lightBlue,
                padding: EdgeInsets.all(16),
                child: HeroDemoApp(
                  image: "http://b-ssl.duitang.com/uploads/item/201603/05/20160305133057_MSNEv.jpeg",
                  width: 200,
                  onTop: (){
                     Navigator.pop(context);
                    },
                  ),
                ),
               );
              }
            ));
          },
        ),
      ),
    );
  }
}

