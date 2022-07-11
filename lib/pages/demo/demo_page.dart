import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/demo/demo_http_page.dart';
import 'package:flutter_trip/util/navigator_util.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
            decoration: const BoxDecoration(color: Colors.white),
            alignment: Alignment.center,
            child: Column(
              children: const [
                RootNavigator(),
              ],
            ))
      ],
    );
  }
}

class RootNavigator extends StatefulWidget {
  const RootNavigator({Key? key}) : super(key: key);

  @override
  State<RootNavigator> createState() => _RootNavigatorState();
}

class _RootNavigatorState extends State<RootNavigator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          _item(context, "Http使用", const NetHttpDemoPage()),
        ],
      ),
    );
  }

  _item(BuildContext context, String title, page) {
    return ElevatedButton(
      onPressed: () {
        NavigatorUtil.push(context, page);
      },
      child: Text(title),
    );
  }
}
