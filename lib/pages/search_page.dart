import 'package:flutter/material.dart';
import 'package:flutter_trip/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
                onChanged: _onTextChanged)
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
