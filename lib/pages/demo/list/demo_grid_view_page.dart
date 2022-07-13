import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DemoGridListView extends StatefulWidget {
  const DemoGridListView({Key? key}) : super(key: key);

  @override
  _DemoGridListViewState createState() => _DemoGridListViewState();
}

const CITY_NAMES = ['北京', '上海', '广州', '深圳', '杭州', '苏州', '成都', '武汉', '郑州', '洛阳', '厦门', '青岛', '拉萨'];

class _DemoGridListViewState extends State<DemoGridListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GridView"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: _buildList(),
      ),
    );
  }

  List<Widget> _buildList() {
    return CITY_NAMES.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      height: 80,
      margin: const EdgeInsets.all(4),
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
