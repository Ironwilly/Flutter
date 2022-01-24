class Disney {
  Disney({
    required this.data,
    required this.count,
    required this.totalPages,
    required this.nextPage,
  });
  late final List<Data> data;
  late final int count;
  late final int totalPages;
  late final String nextPage;

  Disney.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    count = json['count'];
    totalPages = json['totalPages'];
    nextPage = json['nextPage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['count'] = count;
    _data['totalPages'] = totalPages;
    _data['nextPage'] = nextPage;
    return _data;
  }
}

class Data {
  Data({
    required this.films,
    required this.shortFilms,
    required this.tvShows,
    required this.videoGames,
    required this.parkAttractions,
    required this.allies,
    required this.enemies,
    required this._id,
    required this.name,
    required this.imageUrl,
    required this.url,
  });
  late final List<String> films;
  late final List<String> shortFilms;
  late final List<String> tvShows;
  late final List<String> videoGames;
  late final List<String> parkAttractions;
  late final List<dynamic> allies;
  late final List<dynamic> enemies;
  late final int _id;
  late final String name;
  late final String imageUrl;
  late final String url;

  Data.fromJson(Map<String, dynamic> json) {
    films = List.castFrom<dynamic, dynamic>(json['films']);
    shortFilms = List.castFrom<dynamic, dynamic>(json['shortFilms']);
    tvShows = List.castFrom<dynamic, String>(json['tvShows']);
    videoGames = List.castFrom<dynamic, dynamic>(json['videoGames']);
    parkAttractions = List.castFrom<dynamic, dynamic>(json['parkAttractions']);
    allies = List.castFrom<dynamic, dynamic>(json['allies']);
    enemies = List.castFrom<dynamic, dynamic>(json['enemies']);
    _id = json['_id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['films'] = films;
    _data['shortFilms'] = shortFilms;
    _data['tvShows'] = tvShows;
    _data['videoGames'] = videoGames;
    _data['parkAttractions'] = parkAttractions;
    _data['allies'] = allies;
    _data['enemies'] = enemies;
    _data['_id'] = _id;
    _data['name'] = name;
    _data['imageUrl'] = imageUrl;
    _data['url'] = url;
    return _data;
  }
}
