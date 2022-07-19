class ConfigModel {
  late final String? searchUrl;

  ConfigModel({this.searchUrl});

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(
      searchUrl: json["searchUrl"],
    );
  }

  ///反序列化
  Map<String, dynamic> toJson() {
    return {"searchUrl": searchUrl};
  }
}
