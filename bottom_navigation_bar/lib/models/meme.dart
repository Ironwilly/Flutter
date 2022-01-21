class Meme {
  Meme({
    required this.code,
    required this.data,
    required this.message,
    required this.next,
  });
  late final int code;
  late final List<Data> data;
  late final String message;
  late final String next;

  Meme.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    message = json['message'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['message'] = message;
    _data['next'] = next;
    return _data;
  }
}

class Data {
  Data({
    required this.ID,
    this.bottomText,
    required this.image,
    required this.name,
    required this.rank,
    required this.tags,
    this.topText,
  });
  late final int ID;
  late final String? bottomText;
  late final String image;
  late final String name;
  late final int rank;
  late final String tags;
  late final String? topText;

  Data.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    bottomText = null;
    image = json['image'];
    name = json['name'];
    rank = json['rank'];
    tags = json['tags'];
    topText = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ID'] = ID;
    _data['bottomText'] = bottomText;
    _data['image'] = image;
    _data['name'] = name;
    _data['rank'] = rank;
    _data['tags'] = tags;
    _data['topText'] = topText;
    return _data;
  }
}
