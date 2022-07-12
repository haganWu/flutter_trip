import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/demo/demo_http_page.dart';
import 'package:flutter_trip/util/navigator_util.dart';

import 'demo_future_builder_page.dart';
import 'demo_future_page.dart';
import 'demo_shared_preferences_page.dart';
import 'list/demo_list_view_page.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    _item(BuildContext context, String title, page) {
      return ElevatedButton(
        onPressed: () {
          NavigatorUtil.push(context, page);
        },
        child: Text(title),
      );
    }

    return ListView(
      children: [
        Container(
            decoration: const BoxDecoration(color: Colors.white),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        _item(context, "Http使用", const NetHttpDemoPage()),
                        _item(context, "Future使用", const FutureDemoPage()),
                        _item(context, "FutureBuild",
                            const FutureBuilderDemoPage()),
                        _item(context, "SharedPreferences",
                            const DemoSharedPreferences()),
                        _item(context, "ListView使用", const DemoListView()),
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: const [
                        Text("占位1"),
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: const [
                        Text("占位2"),
                      ],
                    )),
              ],
            ))
      ],
    );
  }
}
