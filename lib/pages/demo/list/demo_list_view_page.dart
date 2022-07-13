import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/demo/list/demo_expansion_list_view_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../util/navigator_util.dart';
import 'demo__horizontal_list_view_page.dart';
import 'demo_default_list_view_page.dart';
import 'demo_grid_view_page.dart';

class DemoListView extends StatefulWidget {
  const DemoListView({Key? key}) : super(key: key);

  @override
  _DemoListViewState createState() => _DemoListViewState();
}

class _DemoListViewState extends State<DemoListView> {
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
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  NavigatorUtil.push(context, const DemoDefaultListView());
                },
                child: const Text("默认垂直滑动"),
              ),
              SizedBox.fromSize(
                size: const Size(120, 36),
                child: ElevatedButton(
                  onPressed: () {
                    NavigatorUtil.push(context, const DemoHorizontalListView());
                  },
                  child: const Text("横向滑动"),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.grey,
                    elevation: 6,
                    minimumSize: const Size(500, 200),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  NavigatorUtil.push(context, const DemoExpansionListView());
                },
                child: const Text("可折叠展开"),
              ),
              ElevatedButton(
                onPressed: () {
                  NavigatorUtil.push(context, const DemoGridListView());
                },
                child: const Text("网格布局"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
