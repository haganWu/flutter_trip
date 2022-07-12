import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DemoSharedPreferences extends StatefulWidget {
  const DemoSharedPreferences({Key? key}) : super(key: key);

  @override
  _DemoSharedPreferencesState createState() => _DemoSharedPreferencesState();
}

class _DemoSharedPreferencesState extends State<DemoSharedPreferences> {
  saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('count', 11);
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    final count = prefs.getInt('count') ?? 0;
    print("count:$count");
  }

  deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('count');
    final count = prefs.getInt('count') ?? 0;
    print("count:$count");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SharedPreferences使用"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: ElevatedButton(
                onPressed: () {
                  saveData();
                },
                child: const Text("存储数据"),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: ElevatedButton(
                onPressed: () {
                  getData();
                },
                child: const Text("获取数据"),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: ElevatedButton(
                onPressed: () {
                  deleteData();
                },
                child: const Text("删除数据"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
