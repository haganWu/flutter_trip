import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/model_common.dart';

class FutureBuilderDemoPage extends StatefulWidget {
  const FutureBuilderDemoPage({Key? key}) : super(key: key);

  @override
  _FutureBuilderDemoPageState createState() => _FutureBuilderDemoPageState();
}

class _FutureBuilderDemoPageState extends State<FutureBuilderDemoPage> {

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
        title: const Text("FutureBuilder使用"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder<CommonModel>(
        future: fetchGet(),
          builder: (BuildContext context, AsyncSnapshot<CommonModel> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Text("Input a URL to start");
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
            return const Text("");
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text(
                '${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              );
            } else {
              return Container(
                margin: const EdgeInsets.only(top: 12),
                child: Text(
                  'title:${snapshot.data?.title}, icon:${snapshot.data?.icon},',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
        }
      }),
    );
  }
}
