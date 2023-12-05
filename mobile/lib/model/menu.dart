import 'package:bacaanshalat/model/menu_item.dart';

class Menu {
  Menu({
      this.id, 
      this.name, 
      this.image, 
      this.title, 
      this.createdAt, 
      this.updatedAt, 
      this.menuItems,});

  Menu.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['menu_items'] != null) {
      menuItems = [];
      json['menu_items'].forEach((v) {
        menuItems?.add(MenuItem.fromJson(v));
      });
    }
  }
  int? id;
  String? name;
  String? image;
  String? title;
  String? createdAt;
  String? updatedAt;
  List<MenuItem>? menuItems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['title'] = title;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (menuItems != null) {
      map['menu_items'] = menuItems?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}