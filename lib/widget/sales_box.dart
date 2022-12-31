import 'package:flutter/material.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/util/common_utils.dart';
import 'package:flutter_trip/widget/webview.dart';
import '../model/common_model.dart';
import '../util/navigator_util.dart';

class SalesBox extends StatelessWidget {
  final SalesBoxModel? salesBox;

  const SalesBox({Key? key, this.salesBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: _items(context),
    );
  }

  _items(BuildContext context) {
    if (salesBox == null) {
      return null;
    }
    List<Widget> items = [];
    items.add(_doubleItem(context,salesBox!.bigCard1!, salesBox!.bigCard2!,true, false));
    items.add(_doubleItem(context,salesBox!.smallCard1!, salesBox!.smallCard2!,false, false));
    items.add(_doubleItem(context,salesBox!.smallCard3!, salesBox!.smallCard4!,false, true));


    return Column(
      children: [
        Container(
          height: 44,
          margin: const EdgeInsets.only(left: 10),
          // 设置下划线
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Color(0xfff2f2f2))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(salesBox!.icon!, height: 16, fit: BoxFit.fill),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 1, 8, 1),
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(colors: [Color(0xffff4e63), Color(0xffff6cc9)], begin: Alignment.centerLeft, end: Alignment.centerRight)
                ),
                child: GestureDetector(
                  onTap: (){
                    HiWebView webViewPage = HiWebView(
                        url: CommonUtils.getCatchUrl(salesBox!.moreUrl!), title: "更多活动",);
                    NavigatorUtil.push(context, webViewPage);
                  },
                  child: const Text("获取更多福利 >", style: TextStyle(color: Colors.white, fontSize: 12),),
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(0, 1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(1, 2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(2, 3),
        ),
      ],
    );
  }

  Widget _doubleItem(BuildContext context, CommonModel leftCardModel, CommonModel rightCardModel, bool isBigCard, bool isLastCard) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _item(context, leftCardModel, isBigCard, true, isLastCard),
        _item(context, rightCardModel, isBigCard, false, isLastCard),
      ],
    );

  }

  Widget _item(BuildContext context, CommonModel model,bool isBig, bool isLeftCard, bool isLastCard) {
    BorderSide borderSide = const BorderSide(width: 0.8, color: Color(0xfff2f2f2));
    // 平分布局（weight）
    return GestureDetector(
        onTap: () {
          HiWebView webViewPage = HiWebView(
              url: CommonUtils.getCatchUrl(model.url!),
              statusBarColor: model.statusBarColor,
              hideAppBar: model.hideAppBar);
          NavigatorUtil.push(context, webViewPage);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
                right: isLeftCard ? borderSide : BorderSide.none,
                bottom: isLastCard ? BorderSide.none : borderSide)
          ),
          child: Image.network(
            model.icon!,
            fit: BoxFit.fill,
            // 获取屏幕宽度
            width: MediaQuery.of(context).size.width / 2 - 12,
            height: isBig ? 128 : 80,
          ),
        ),
      );
  }
}
