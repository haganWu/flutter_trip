import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/home_page.dart';
import 'package:flutter_trip/pages/my_page.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/travel_page.dart';

import '../pages/demo/demo_page.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({Key? key}) : super(key: key);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _selectColor = Colors.blue;
  int _currentIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: const [
          HomePage(),
          SearchPage(),
          TravelPage(),
          MyPage(),
          DemoPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,//将label固定
        unselectedItemColor: _defaultColor,
        selectedItemColor:_selectColor ,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: _defaultColor),
              activeIcon: Icon(Icons.home, color: _selectColor),
              label: "首页"),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: _defaultColor),
              activeIcon: Icon(Icons.search, color: _selectColor),
              label: "搜索"),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt, color: _defaultColor),
              activeIcon: Icon(Icons.camera_alt, color: _selectColor),
              label: "旅拍"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: _defaultColor),
              activeIcon: Icon(Icons.account_circle, color: _selectColor),
              label: "我的"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: _defaultColor),
              activeIcon: Icon(Icons.settings, color: _selectColor),
              label: "Demo"),
        ],
      ),
    );
  }
}
