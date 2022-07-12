import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FutureDemoPage extends StatefulWidget {
  const FutureDemoPage({Key? key}) : super(key: key);

  @override
  _FutureDemoPageState createState() => _FutureDemoPageState();
}

class _FutureDemoPageState extends State<FutureDemoPage> {
  test() async {
    int result = await Future.delayed(const Duration(milliseconds: 3000), () {
      return Future.value(123);
    });
    print("t3:" + DateTime.now().toString());
    print(result);
  }

  testFutureThen() {
    print("t1:" + DateTime.now().toString());
    test();
    print("t2:" + DateTime.now().toString());
  }

  testFutureWhenComplete() {
    var random = Random();
    Future.delayed(const Duration(seconds: 3), () {
      if (random.nextBool()) {
        return 100;
      } else {
        throw "boom";
      }
    }).then(print).catchError(print).whenComplete(() => print("Complete"));
  }

  testFutureTimeout() {
    Future.delayed(const Duration(seconds: 3), () {
      return 1;
    }).timeout(const Duration(seconds: 2)).then((value) => print).catchError(print);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Future使用"),
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
          children: <Widget>[
            InkWell(
              onTap: () {
                testFutureThen();
              },
              child: const Text(
                'TestFutureThen',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
            InkWell(
              onTap: () {
                testFutureWhenComplete();
              },
              child: const Text(
                'TestFutureComplete',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
            InkWell(
              onTap: () {
                testFutureTimeout();
              },
              child: const Text(
                'TestFutureTimeout',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
