import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:http/http.dart' as http;


class NetHttpDemoPage extends StatefulWidget {
  const NetHttpDemoPage({Key? key}) : super(key: key);

  @override
  _NetHttpDemoPageState createState() => _NetHttpDemoPageState();
}

class _NetHttpDemoPageState extends State<NetHttpDemoPage> {
  String showResult = "";
  String iconUrl = "";

  Future<CommonModel> fetchGet() async {
    var url = Uri.parse(
        'http://www.devio.org/io/flutter_app/json/test_common_model.json');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = const Utf8Decoder(); // fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return CommonModel.fromJson(result);
    } else {
      throw Exception('Failed to load home_page.json');
    }
  }

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
          children: <Widget>[
            InkWell(
              onTap: () {
                fetchGet().then((value) => setState(() {
                      showResult =
                          '请求结果：\ntitle:${value.title}\nurl:${value.url}';
                      iconUrl = value.icon!;
                    }));
              },
              child: const Text(
                '发起请求',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12),
              child: Text(
                showResult,
                style: const TextStyle(color: Colors.red),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12),
              child: Image.network(iconUrl, width: 66, height: 66),
            ),
          ],
        ),
      ),
    );
  }
}

