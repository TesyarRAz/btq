class MenuItem {
  MenuItem({
    this.id,
    this.name,
    this.arabic,
    this.latin,
    this.terjemahan,
    this.isFavorite,
  });

  MenuItem.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    arabic = json['arabic'];
    latin = json['latin'];
    terjemahan = json['terjemahan'];
    isFavorite = json['is_favorite'];
  }

  int? id;
  String? name;
  String? arabic;
  String? latin;
  String? terjemahan;
  bool? isFavorite;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['arabic'] = arabic;
    map['latin'] = latin;
    map['terjemahan'] = terjemahan;
    map['is_favorite'] = isFavorite;
    return map;
  }
}
