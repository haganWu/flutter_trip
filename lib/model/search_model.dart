class SearchModel {
  List<SearchItem>? data;
  String? resultPageUrl;
  String? keyword;

  SearchModel({this.data, this.resultPageUrl, this.keyword});

  SearchModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SearchItem>[];
      json['data'].forEach((item) {
        data!.add(SearchItem.fromJson(item));
      });
    }
    resultPageUrl = json['resultPageUrl'];
    keyword = json['keyword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['resultPageUrl'] = this.resultPageUrl;
    data['keyword'] = this.keyword;
    return data;
  }
}

class SearchItem {
  String? code;
  String? word;
  String? type;
  String? districtname;
  String? url;
  bool? isBigIcon;
  String? price;
  String? zonename;
  String? star;
  String? imageUrl;
  String? subImageUrl;
  String? sourceType;

  SearchItem(
      {this.code,
        this.word,
        this.type,
        this.districtname,
        this.url,
        this.isBigIcon,
        this.price,
        this.zonename,
        this.star,
        this.imageUrl,
        this.subImageUrl,
        this.sourceType});

  SearchItem.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    word = json['word'];
    type = json['type'];
    districtname = json['districtname'];
    url = json['url'];
    isBigIcon = json['isBigIcon'];
    price = json['price'];
    zonename = json['zonename'];
    star = json['star'];
    imageUrl = json['imageUrl'];
    subImageUrl = json['subImageUrl'];
    sourceType = json['sourceType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['word'] = this.word;
    data['type'] = this.type;
    data['districtname'] = this.districtname;
    data['url'] = this.url;
    data['isBigIcon'] = this.isBigIcon;
    data['price'] = this.price;
    data['zonename'] = this.zonename;
    data['star'] = this.star;
    data['imageUrl'] = this.imageUrl;
    data['subImageUrl'] = this.subImageUrl;
    data['sourceType'] = this.sourceType;
    return data;
  }
}
