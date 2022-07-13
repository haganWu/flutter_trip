import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DemoExpansionListView extends StatefulWidget {
  const DemoExpansionListView({Key? key}) : super(key: key);

  @override
  _DemoExpansionListViewState createState() => _DemoExpansionListViewState();
}

const CITY_NAMES = {
  '北京': ['东城区', '西城区', '朝阳区', '丰台区', '石景山区', '海淀区', '顺义区'],
  '上海': ['黄浦区', '徐汇区', '长宁区', '静安区', '普陀区', '闸北区', '虹口区'],
  '广州': ['越秀', '海珠', '荔湾', '天河', '白云', '黄埔', '南沙', '番禺'],
  '深圳': ['南山', '福田', '罗湖', '盐田', '龙岗', '宝安', '龙华'],
  '杭州': ['上城区', '下城区', '江干区', '拱墅区', '西湖区', '滨江区'],
  '苏州': ['姑苏区', '吴中区', '相城区', '高新区', '虎丘区', '工业园区', '吴江区']
};

class _DemoExpansionListViewState extends State<DemoExpansionListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ExpansionListView"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        children: _buildList(),
      ),
    );
  }

  List<Widget> _buildList() {
    List<Widget> widgets = [];
    for (var key in CITY_NAMES.keys) {
      widgets.add(_item(key, CITY_NAMES[key]!));
    }
    return widgets;
  }

  Widget _item(String city, List<String> subCities) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Colors.red, Colors.orange]),
      ),
      child: ExpansionTile(
        title: Text(city,
            style: const TextStyle(color: Colors.black54, fontSize: 20)),
        children: subCities.map((subCity) => _buildSub(subCity)).toList(),
      ),
    );
  }

  Widget _buildSub(String city) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        margin: const EdgeInsets.only(bottom: 1),
        padding: const EdgeInsets.only(left: 12, top: 4, right: 12, bottom: 4),
        decoration: const BoxDecoration(color: Colors.lightBlue),
        child: Text(
          city,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
