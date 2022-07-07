import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/demo/demo_http_page.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo",
      home: Scaffold(
          body: ListView(
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
      )),
      routes: <String, WidgetBuilder>{
        'http': (BuildContext context) => const NetHttpDemoPage(),
      },
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
          _item("Http使用", const NetHttpDemoPage(), "http"),
        ],
      ),
    );
  }

  _item(String title, page, String routeName) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Text(title),
    );
  }
}
