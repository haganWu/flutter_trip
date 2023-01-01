import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/search_dao.dart';
import 'package:flutter_trip/model/search_model.dart';
import 'package:flutter_trip/widget/search_bar.dart';

import '../util/common_utils.dart';
import '../util/navigator_util.dart';
import '../widget/webview.dart';


class SearchPage extends StatefulWidget {

  final bool? hideLeft;
  final String? searchUrl;
  final String? keyword;
  final String? hint;

  const SearchPage({
    Key? key,
    this.hideLeft = true,
    this.searchUrl = "https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword=",
    this.keyword = "",
    this.hint = ""
  }) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  SearchModel? searchModel;
  String? keyword;

  @override
  void initState() {
    super.initState();
  }

  _getData(String url) async {
    try {
      SearchModel model = await SearchDao.fetch(url,keyword);
      print("keyword:"+model.keyword!);
      if(keyword == model.keyword) {
        setState(() {
          searchModel = model;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            _appBar,
            // 去除ListView顶部空白
            MediaQuery.removePadding(
              removeTop: true,
                context: context,
                child: Expanded(
                    flex: 1,
                    child:  ListView.builder(
                        itemCount: searchModel?.data?.length??0,
                        itemBuilder: (BuildContext context, int position){
                          return _item(position);
                        }
                    ))
            )
          ],
    ));
  }

  _item(int position) {
    if(searchModel == null || searchModel?.data == null) {
      return null;
    }
    SearchItem? item = searchModel?.data![position];
    return GestureDetector(
      onTap: (){
        HiWebView webViewPage = HiWebView(
            url: CommonUtils.getCatchUrl(item!.url!),hideAppBar: true);
        NavigatorUtil.push(context, webViewPage);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))
        ),
        child: Row(
         children: [
          if (item?.imageUrl != null) Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
              ),
            margin: const EdgeInsets.only(right: 6),
             alignment: Alignment.center,
               child: Image.network(item!.imageUrl!,width: 26, height: 26, fit: BoxFit.fill,)
           ),
           Column(
             children: [
               SizedBox(
                 child: Row(
                   children: [
                     Container(
                       margin: const EdgeInsets.only(right: 12),
                       child:  Text(item!.word!, style: const TextStyle(color: Colors.black, fontSize: 14),),
                     ),

                    if(item.word!.length < 10) Text(item.districtname ?? "", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    if(item.word!.length < 10 && (item.districtname != null && item.districtname!.length < 6)) Text(item.zonename ?? "", style: const TextStyle(color: Colors.grey, fontSize: 12))

                   ],
                 ),
               )

             ],
           )
         ],
        ),
      ),
    );
  }

  Widget get _appBar {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            // 状态栏颜色渐变
            gradient: LinearGradient(
              colors: [Color(0x66000000), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            height: 80,
            // decoration: const BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [Color(0x66000000), Colors.transparent],
            //       begin: Alignment.topCenter,
            //       end: Alignment.bottomCenter,
            //     )
            // ),
            child: SearchBar(
                enabled: true,
                hideLeft: widget.hideLeft,
                searchBarType: SearchBarType.normal,
                hint: widget.hint,
                defaultText: widget.keyword,
                leftButtonClick: (){ Navigator.pop(context);},
                rightButtonClick: _rightButtonClick,
                speakClick: _speakClick,
                inputBoxClick: _inputBoxClick,
                onChanged: _onTextChanged),
          ),
        )
      ],
    );
  }

  _rightButtonClick() {

  }
  _speakClick() {

  }
  _inputBoxClick() {

  }
   _onTextChanged(String text) {
    print("SearchPage _onTextChanged text:" + text);
      keyword = text;
      if(keyword == null || keyword?.length == 0) {
        setState((){
          searchModel = null;
        });
        return;
      }
      String url = widget.searchUrl! + keyword!;
      _getData(url);
  }
}
