import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/loading_container.dart';
import 'package:flutter_trip/widget/sales_box.dart';
import 'package:flutter_trip/widget/search_bar.dart';
import 'package:flutter_trip/widget/sub_nav.dart';

import '../model/grid_nav_model.dart';
import '../util/common_utils.dart';
import '../util/navigator_util.dart';
import '../widget/local_nav.dart';
import '../widget/webview.dart';

const appbarScrollOffset = 100;
const searchBarDefaultText = "网红打卡 景点 酒店 美食";
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double appBarAlpha = 0;
  bool _isLoading = true;
  List<CommonModel>? bannerList = [];
  List<CommonModel>? localNavList = [];
  GridNavModel? gridNavModel;
  List<CommonModel>? subNavList = [];
  SalesBoxModel? salesBoxModel;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

 Future<void> _handleRefresh() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        bannerList = model.bannerList;
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
        subNavList = model.subNavList;
        salesBoxModel = model.salesBox;
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState((){
        _isLoading = false;
      });
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
        body: LoadingContainer(
          isLoading: _isLoading,
          child: Stack(
            children: [
              MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: RefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: NotificationListener(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollUpdateNotification &&
                          scrollNotification.depth == 0) {
                        //滚动并且是列表滚动的时候
                        _onScroll(scrollNotification.metrics.pixels);
                      }
                      return false;
                    },
                    child: _listView,
                  ),
                ),
              ),
              _appBar
            ],
        ),)); //移除顶部padding
  }

  Widget get _appBar {
   return Column(
     children: [
       Container(
         decoration: const BoxDecoration(
           gradient: LinearGradient(
             colors: [Color(0x66000000), Colors.transparent],
             begin: Alignment.topCenter,
             end: Alignment.bottomCenter,
           )
         ),
         child: Container(
           padding: const EdgeInsets.only(top: 20),
           height: 80,
           decoration: BoxDecoration(
             color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255)
           ),
           child: SearchBar(
               defaultText: searchBarDefaultText,
               searchBarType: appBarAlpha > 0.2 ? SearchBarType.homeLight : SearchBarType.home,
               leftButtonClick: _searchBarLeftButtonClick,
               rightButtonClick: _searchBarRightButtonClick,
               speakClick: _searchBarSpeakClick,
               inputBoxClick: _searchBarInputBoxClick,
               onChanged: _onTextChanged
           ),
         ),
       ),
       Container(
         height: appBarAlpha > 0.2 ? 0.5 : 0,
         decoration: const BoxDecoration(
           boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]
         ),
       )
     ],
   );
  }

  _searchBarLeftButtonClick() {
  }
  _searchBarRightButtonClick() {
  }
  _searchBarSpeakClick() {

  }
  _searchBarInputBoxClick() {
    NavigatorUtil.push(context, const SearchPage(hideLeft:false, hint: searchBarDefaultText,));
  }
  _onTextChanged(text) {

  }

  Widget get _listView {
    return ListView(
      children: [
        _banner,
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
        Padding(
          padding: const EdgeInsets.fromLTRB(6, 0, 6, 4),
          child: SalesBox(salesBox: salesBoxModel),
        ),
      ],
    );
  }

  Widget get _banner {
    return SizedBox(
      height: 180,
      child: Swiper(
        itemCount: bannerList!.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){
              HiWebView webViewPage = HiWebView(
                  url: CommonUtils.getCatchUrl(bannerList![index].url!),hideAppBar: true);
              NavigatorUtil.push(context, webViewPage);
            },
            child: Image.network(
              bannerList![index].icon!,
              fit: BoxFit.fill,
            ),
          );
        },
        pagination: const SwiperPagination(),
      ), //轮播
    );
  }
}
