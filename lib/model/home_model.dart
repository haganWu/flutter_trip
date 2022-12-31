import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/config_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';

class HomeModel {
  late final ConfigModel? config;
  late final List<CommonModel>? bannerList;
  late final List<CommonModel>? localNavList;
  late final GridNavModel? gridNav;
  late final List<CommonModel>? subNavList;
  late final SalesBoxModel? salesBox;

  HomeModel(
      {this.config,
      this.bannerList,
      this.localNavList,
      this.gridNav,
      this.subNavList,
      this.salesBox});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var bannerListJson = json["bannerList"] as List;
    List<CommonModel> bannerList =
        bannerListJson.map((e) => CommonModel.fromJson(e)).toList();

    var localNavListJson = json["localNavList"] as List;
    List<CommonModel> localNavList =
        localNavListJson.map((e) => CommonModel.fromJson(e)).toList();

    var subNavListJson = json["subNavList"] as List;
    List<CommonModel> subNavList =
        subNavListJson.map((e) => CommonModel.fromJson(e)).toList();
    return HomeModel(
      config: ConfigModel.fromJson(json["config"]),
      bannerList: bannerList,
      localNavList: localNavList,
      gridNav: GridNavModel.fromJson(json["gridNav"]),
      subNavList: subNavList,
      salesBox: SalesBoxModel.fromJson(json["salesBox"]),
    );
  }

  ///反序列化
  Map<String, dynamic> toJson() {
    return {
      "config": config,
      "bannerList": bannerList,
      "localNavList": localNavList,
      "gridNav": gridNav,
      "subNavList": subNavList,
      "salesBox": salesBox,
    };
  }
}
