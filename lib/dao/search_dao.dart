import 'package:flutter_trip/model/search_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// const SEARCH_URL = "https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword=";

class SearchDao {
  static Future<SearchModel> fetch(String searchUrl, String? keyword) async {
    var url = Uri.parse(searchUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = const Utf8Decoder(); // 防止中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      SearchModel model =  SearchModel.fromJson(result);
      model.keyword = keyword;
      return model;
    } else {
      throw Exception('Failed to load search_page.json');
    }
  }
}
