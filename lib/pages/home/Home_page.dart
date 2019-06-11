import 'package:flutter/material.dart';
import 'package:hxsly_app/dao/home_dao.dart';
import 'package:hxsly_app/model/common_model.dart';
import 'package:hxsly_app/model/gridnav_model.dart';
import 'package:hxsly_app/model/home_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hxsly_app/model/salesbox_model.dart';
import 'package:hxsly_app/widget/grid_nav.dart';
import 'package:hxsly_app/widget/loadint_container.dart';
import 'package:hxsly_app/widget/local_nav.dart';
import 'package:hxsly_app/widget/sales_box.dart';
import 'package:hxsly_app/widget/sub_nav.dart';
import 'package:hxsly_app/widget/web_view.dart';

const APPBAR_SCROLL_OFFISET = 150; //滚动最大的距离

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  double appBarAloha = 0;
  List<CommonModel> localNavList = [];
  GridNavModel gridNavModel;
  List<CommonModel> bannerList = [];
  List<CommonModel> subList = [];
  SalesBoxModel salesBoxModel;
  bool _loading = true;

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
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
        bannerList = model.bannerList;
        subList = model.subNavList;
        salesBoxModel = model.salesBox;
        print(resultsST);
      });
      _loading = false;
    } catch (e) {
      setState(() {
        _loading = false;
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
        backgroundColor: Color(0xfff2f2f2),
        body: LoadingContainer(
          isLoading: _loading,
          child: new Stack(
            children: <Widget>[
              new MediaQuery.removePadding(
                  removeTop: true, //去除顶部padding
                  context: context,
                  child: NotificationListener(
                    //监听列表滚动
                    onNotification: (scroll) {
                      if (scroll is ScrollUpdateNotification &&
                          scroll.depth == 0) {
                        //第0个元素 才触发监听
                        onScroll(scroll.metrics.pixels);
                      }
                    },
                    child: new ListView(
                      children: <Widget>[
                        new Container(
                          height: 200,
                          child: new Swiper(
                            itemCount: bannerList.length,
                            autoplay: false,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      new MaterialPageRoute(builder: (context) {
                                        CommonModel model = bannerList[index];
                                        return WebView(
                                          url: model.url,
                                          title: model.title,
                                          hideAppBar: model.hideAppBar,
                                        );
                                      }));
                                },
                                child: Image.network(
                                  bannerList[index].icon,
                                  fit: BoxFit.fill,
                                ),
                              );
                            },
                            controller: new SwiperController(),
                          ),
                        ),
                        new Padding(
                          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                          child: LocalNav(localNavList: localNavList),
                        ),
                        new Padding(
                          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                          child: GridNav(gridNavModel: gridNavModel),
                        ),
                        new Padding(
                          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                          child: SubNav(subNavList: subList),
                        ),
                        new Padding(
                          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                          child: SalesBox(
                            salesBox: salesBoxModel,
                          ),
                        ),
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
          ),

        ));
  }

}
