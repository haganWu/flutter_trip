import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/sub_nav.dart';

import '../model/grid_nav_model.dart';
import '../widget/local_nav.dart';

const appbarScrollOffset = 100;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List _imageUrls = [
    'http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg',
    'https://dimg04.c-ctrip.com/images/700u0r000000gxvb93E54_810_235_85.jpg',
    'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg'
  ];
  List<CommonModel>? localNavList = [];
  late GridNavModel gridNavModel;
  List<CommonModel>? subNavList = [];
  double appBarAlpha = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        gridNavModel = model.gridNav!;
        subNavList = model.subNavList;
      });
    } catch (e) {
      print(e);
    }
  }

  _onScroll(offset) {
    print("offset:$offset");
    double alpha = offset / appbarScrollOffset;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print("appBarAlpha:$appBarAlpha");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff2f2f2),
        body: Stack(
          children: [
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: NotificationListener(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollUpdateNotification &&
                      scrollNotification.depth == 0) {
                    //滚动并且是列表滚动的时候
                    _onScroll(scrollNotification.metrics.pixels);
                  }
                  return false;
                },
                child: ListView(
                  children: [
                    SizedBox(
                      height: 180,
                      child: Swiper(
                        itemCount: _imageUrls.length,
                        autoplay: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            _imageUrls[index],
                            fit: BoxFit.fill,
                          );
                        },
                        pagination: const SwiperPagination(),
                      ), //轮播
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                      child: LocalNav(localNavList: localNavList),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 0, 6, 4),
                      child: GridNav(gridNavModel: gridNavModel),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 0, 6, 4),
                      child: SubNav(subNavList: subNavList),
                    ),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: appBarAlpha,
              child: Container(
                height: 60,
                decoration: const BoxDecoration(color: Colors.red),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text("首页"),
                  ),
                ),
              ),
            )
          ],
        )); //移除顶部padding
  }
}
