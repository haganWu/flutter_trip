import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/util/navigator_util.dart';
import 'package:flutter_trip/widget/webview.dart';

import '../util/common_utils.dart';

class GridNav extends StatelessWidget {
  final GridNavModel? gridNavModel;
  final String name;

  const GridNav({Key? key, this.gridNavModel, this.name = "HA"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _gridViewItems(context),
    );
  }

  _gridViewItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNavModel == null) {
      return items;
    }

    if (gridNavModel?.hotel != null) {
      _gridViewItem(context, gridNavModel!.hotel!, true, false);
    }
    if (gridNavModel?.flight != null) {
      _gridViewItem(context, gridNavModel!.flight!, false, false);
    }
    if (gridNavModel?.travel != null) {
      _gridViewItem(context, gridNavModel!.travel!, false, true);
    }
  }

  _gridViewItem(BuildContext context, GridNavItem gridNavItem, bool isFirst,
      bool isLast) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem.mainItem!));
    items.add(
        _doubleItem(context, gridNavItem.item1!, gridNavItem.item2!, true));
    items.add(
        _doubleItem(context, gridNavItem.item3!, gridNavItem.item4!, false));
    List<Widget> expandedItems = [];
    for (var element in items) {
      expandedItems.add(Expanded(
        child: element,
        flex: 1,
      ));
    }
    Color startColor = Color(int.parse('0xff' + gridNavItem.startColor!));
    Color endColor = Color(int.parse('0xff' + gridNavItem.endColor!));
    return Container(
      height: 88,
      margin: isFirst ? null : const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
          //线性渐变
          gradient: LinearGradient(colors: [startColor, endColor]),
          borderRadius: isFirst
              ? const BorderRadius.only(
                  topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0))
              : (isLast
                  ? const BorderRadius.only(
                      bottomLeft: Radius.circular(6.0),
                      bottomRight: Radius.circular(6.0))
                  : null)),
      child: Row(
        children: expandedItems,
      ),
    );
  }

  _mainItem(BuildContext context, CommonModel commonModel) {
    return _wrapGesture(
        context,
        Stack(
          children: [
            Image.network(
              commonModel.icon!,
              fit: BoxFit.contain,
              height: 88,
              width: 122,
              alignment: AlignmentDirectional.bottomEnd,
            ),
            Text(
              commonModel.title!,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            )
          ],
        ),
        commonModel);
  }

  _doubleItem(BuildContext context, CommonModel topItem, CommonModel bottomItem,
      bool isCenter) {
    return Column(
      children: [
        Expanded(child: _item(context, topItem, true, isCenter)),
        Expanded(child: _item(context, bottomItem, false, isCenter)),
      ],
    );
  }

  _item(BuildContext context, CommonModel item, bool isFirst, bool isCenter) {
    BorderSide borderSide = const BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: borderSide,
              bottom: isFirst ? borderSide : BorderSide.none,
              right: isCenter ? borderSide : BorderSide.none,
            ),
          ),
          child: _wrapGesture(
              context,
              Center(
                child: Text(item.title!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.white)),
              ),
              item),
        ));
  }

  _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: () {
        HiWebView webViewPage = HiWebView(
            url: CommonUtils.getCatchUrl(model.url!),
            statusBarColor: model.statusBarColor,
            hideAppBar: model.hideAppBar);
        NavigatorUtil.push(context, webViewPage);
      },
      child: widget,
    );
  }
}
