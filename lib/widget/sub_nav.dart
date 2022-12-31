import 'package:flutter/material.dart';
import 'package:flutter_trip/util/common_utils.dart';
import 'package:flutter_trip/widget/webview.dart';
import '../model/common_model.dart';
import '../util/navigator_util.dart';

class SubNav extends StatelessWidget {
  final List<CommonModel>? subNavList;

  const SubNav({Key? key, this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (subNavList == null || subNavList!.isEmpty) {
      return null;
    }
    List<Widget> items = [];
    for (int i = 0; i < subNavList!.length; i++) {
      items.add(_item(context, subNavList![i]));
    }
    // 计算第一行显示的数量
    int separate = (subNavList!.length / 2 + 0.5).toInt();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, separate),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(separate, items.length),
        ))
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    // 平分布局（weight）
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          HiWebView webViewPage = HiWebView(
              url: CommonUtils.getCatchUrl(model.url!),
              statusBarColor: model.statusBarColor,
              hideAppBar: model.hideAppBar);
          NavigatorUtil.push(context, webViewPage);
        },
        child: Column(
          children: [
            Image.network(
              model.icon!,
              width: 18,
              height: 18,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  model.title!,
                  style: const TextStyle(fontSize: 12),
                ))
          ],
        ),
      ),
    );
  }
}
