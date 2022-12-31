
import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';

class LocalNav extends StatelessWidget {

  final List<CommonModel> localNavList;

  const LocalNav({Key? key, required this.localNavList}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(padding: const EdgeInsets.all(8),
      child: _items(context)),
    );
    }
  _items(BuildContext context){
    if(localNavList.isEmpty) {
      return null;
    }
    List<Widget> items = [];
    for (var element in localNavList) {
      items.add(_item(context, element));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return GestureDetector(
      onTap: (){

      },
      child: Column(
        children: [
          Image.network(model.icon!,width: 32,height: 32,),
          Text(model.title!, style: const TextStyle(fontSize: 12))
        ],
      ),
    );
  }

}