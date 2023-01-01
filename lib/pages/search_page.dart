import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/search_dao.dart';
import 'package:flutter_trip/model/search_model.dart';
import 'package:flutter_trip/widget/search_bar.dart';

class SearchPage extends StatefulWidget {

  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final String SEARCH_URL = "https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword=";
  String showText = "11";
  @override
  void initState() {
    super.initState();
  }

  _getData() async {
    try {
      SearchModel model = await SearchDao.fetch(SEARCH_URL);
      print(json.encode(model.data![0]));
      setState(() {
        showText = json.encode(model.data![0]);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            SearchBar(
                enabled: true,
                hideLeft: true,
                searchBarType: SearchBarType.normal,
                hint: "123",
                defaultText: "456",
                leftButtonClick: (){ Navigator.pop(context);},
                rightButtonClick: _rightButtonClick,
                speakClick: _speakClick,
                inputBoxClick: _inputBoxClick,
                onChanged: _onTextChanged),
            InkWell(
              onTap: (){
                _getData();
              },
              child: Text("Get"),
            ),
            Text(showText)
          ],
    ));
  }

  _rightButtonClick() {

  }
  _speakClick() {

  }
  _inputBoxClick() {

  }
   _onTextChanged(text) {

  }
}
