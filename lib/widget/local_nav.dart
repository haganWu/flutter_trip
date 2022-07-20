import 'package:flutter/material.dart';
import '../model/common_model.dart';

class LocalNav extends StatelessWidget {
  final List<CommonModel>? localNavList;

  const LocalNav({Key? key, this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
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
    if (localNavList == null || localNavList!.isEmpty) {
      return null;
    }
    List<Widget> items = [];
    for (int i = 0; i < localNavList!.length; i++) {
      items.add(_item(context, localNavList![i]));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Image.network(
            model.icon!,
            width: 32,
            height: 32,
          ),
          Text(
            model.title!,
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
