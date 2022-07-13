import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DemoHorizontalListView extends StatefulWidget {
  const DemoHorizontalListView({Key? key}) : super(key: key);

  @override
  _DemoHorizontalListViewState createState() => _DemoHorizontalListViewState();
}

const CITY_NAMES = [
  "郑州",
  "深圳",
  "北京",
  "上海",
  "广州",
  "西安",
  "重庆",
  "南京",
  "延安",
  "苏州",
  "杭州"
];

class _DemoHorizontalListViewState extends State<DemoHorizontalListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ListView"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: SizedBox(
        height: 200,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: _buildList(),
        ),
      ),
    );
  }

  List<Widget> _buildList() {
    return CITY_NAMES.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(left: 16, top: 6, right: 16, bottom: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Colors.red, Colors.orange]),
          //背景渐变
          borderRadius: BorderRadius.circular(6.0),
          //3像素圆角
          boxShadow: const [
            //阴影
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
