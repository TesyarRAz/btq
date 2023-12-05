class MenuItem {
  MenuItem({
      this.id, 
      this.name, 
      this.arabic, 
      this.latin, 
      this.terjemahan,});

  MenuItem.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    arabic = json['arabic'];
    latin = json['latin'];
    terjemahan = json['terjemahan'];
  }
  int? id;
  String? name;
  String? arabic;
  String? latin;
  String? terjemahan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['arabic'] = arabic;
    map['latin'] = latin;
    map['terjemahan'] = terjemahan;
    return map;
  }

}