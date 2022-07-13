import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DemoRefreshMoreListView extends StatefulWidget {
  const DemoRefreshMoreListView({Key? key}) : super(key: key);

  @override
  _DemoRefreshMoreListViewState createState() =>
      _DemoRefreshMoreListViewState();
}

List<String>  cityNames = [
  '北京',
  '上海',
  '广州',
  '深圳',
  '杭州',
  '苏州',
  '成都',
  '武汉',
  '郑州',
  '洛阳',
  '厦门',
  '青岛',
  '拉萨'
];

class _DemoRefreshMoreListViewState extends State<DemoRefreshMoreListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("下拉刷新/上拉加载更多"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh, //下拉刷新
        child: ListView(
          controller: _scrollController,
          children: _buildList(),
        ),
      ),
    );
  }

  _loadData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      List<String> list = List<String>.from(cityNames);
      list.addAll(cityNames);
      cityNames = list;
    });
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      cityNames = cityNames.reversed.toList();
    });
  }

  List<Widget> _buildList() {
    return cityNames.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(left: 16, top: 6, right: 16, bottom: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          //背景渐变
          gradient: const LinearGradient(colors: [Colors.red, Colors.orange]),
          //6像素圆角
          borderRadius: BorderRadius.circular(6.0),
          //阴影
          boxShadow: const [
            BoxShadow(
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0)
          ]),
      child: Text(
        city,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
