import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NetHttpDemoPage extends StatefulWidget {
  const NetHttpDemoPage({Key? key}) : super(key: key);

  @override
  _NetHttpDemoPageState createState() => _NetHttpDemoPageState();
}

class _NetHttpDemoPageState extends State<NetHttpDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Http使用"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Http使用',
            ),
          ],
        ),
      ),
    );
  }
}
