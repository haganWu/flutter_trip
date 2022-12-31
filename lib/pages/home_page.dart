import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/home_model.dart';

const APPBAR_SCROLL_OFFSET = 100;

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
  String resultString = "11";
  double appBarAlpha = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    // HomeDao.fetch().then((result) {
    //   setState(() {
    //     resultString = json.encode(result);
    //   });
    // }).catchError((error) {
    //   setState(() {
    //     resultString = error.toString();
    //   });
    // });

    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        resultString = json.encode(model.salesBox);
      });
    } catch (e) {
      setState(() {
        resultString = e.toString();
      });
    }
  }

  _onScroll(offset) {
    print("offset:$offset");
    double alpha = offset / APPBAR_SCROLL_OFFSET;
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
                SizedBox(
                  height: 860,
                  child: ListTile(
                    title: Text(resultString),
                  ),
                )
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
