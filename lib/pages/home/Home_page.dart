import 'package:flutter/material.dart';
import 'package:hxsly_app/dao/home_dao.dart';
import 'dart:convert';
import 'dart:async';
import 'package:hxsly_app/model/home_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const APPBAR_SCROLL_OFFISET = 150; //滚动最大的距离
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  List _images = [
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558325125847&di=8592b2804eb52e7e3760dc89eff99543&imgtype=0&src=http%3A%2F%2Fpic40.nipic.com%2F20140412%2F18428321_144447597175_2.jpg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558325125847&di=dd7c90fe418030f53d674b773861fac3&imgtype=0&src=http%3A%2F%2Fpic37.nipic.com%2F20140113%2F8800276_184927469000_2.png',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558325125847&di=8c37fac950dec0963252d401ddfc0168&imgtype=0&src=http%3A%2F%2Fpic15.nipic.com%2F20110628%2F1369025_192645024000_2.jpg'
  ];
  double appBarAloha = 0;

  onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFISET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAloha = alpha;
    });
    print(appBarAloha);
  }


  String resultsST = "1";

  ///async 第二种
  loadData() async {
    ///获取数据的第一种方式
    /*  HomeDao.fetch().then((result) {
      setState(() {
        resultsST = json.encode(result);
      });
    }).catchError((e) {
      print("解析出错"+e.toString());
      setState(() {
        resultsST = e.toString();
      });
    });*/

    ///第二种
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        resultsST = model.salesBox.icon;
        print(resultsST);
      });
    } catch (e) {
      setState(() {
        resultsST = e.toString();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///请求数据
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        body: new Stack(
          children: <Widget>[
            new MediaQuery.removePadding(
                removeTop: true, //去除顶部padding
                context: context,
                child: NotificationListener(
                  //监听列表滚动
                  onNotification: (scroll) {
                    if (scroll is ScrollUpdateNotification && scroll.depth == 0) {   //第0个元素 才触发监听
                      onScroll(scroll.metrics.pixels);
                    }
                  },
                  child: new ListView(
                    children: <Widget>[
                      new Container(
                        height: 200,
                        child: new Swiper(
                          itemCount: _images.length,
                          autoplay: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(
                              _images[index],
                              fit: BoxFit.fill,
                            );
                          },
                          pagination: SwiperPagination(),
                          controller: new SwiperController(),
                        ),
                      ),
                      new Container(
                        height: 800,
                        child: new Text(resultsST),
                      ),
                      InkWell(
                        onTap: (){

                        },
                        child: new Text('网络请求',style: TextStyle(fontSize: 30),),
                      )
                    ],
                  ),
                )),
            new Opacity(
              opacity: appBarAloha,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: new Center(
                  child: new Padding(
                    padding: EdgeInsets.only(top: 35),
                    child: new Text('首页'),
                  ),
                ),
              ),
            ),

          ],
        ));
  }
}
