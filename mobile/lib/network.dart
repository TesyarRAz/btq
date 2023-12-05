import 'dart:convert';

import 'package:bacaanshalat/model/menu.dart';
import 'package:bacaanshalat/model/menu_item.dart';
import 'package:dio/dio.dart';

class Network {
  static String BASE_URL = "http://10.0.2.2:8000/api";

  Network._();

  static Network? _instance;

  static Network get instance {
    _instance ??= Network._();

    return _instance!;
  }

  final dio = Dio(
    BaseOptions(
      responseType: ResponseType.json,
    ),
  );

  Future<List<Menu>> getMenu([String? token]) async {
      Map<String, dynamic> headers = {};
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      var response = await dio.get("$BASE_URL/menu", options: Options(
        headers: headers,
      ));

      if (response.statusCode == 200) {
        return (response.data['data'] as List<dynamic>).map((e) => Menu.fromJson(e)).toList();
      }

      return [];
  }

  Future<bool> favoriteMenuItem(int id, String token) async {
    var response = await dio.post("$BASE_URL/menu/${id}/favorite", options: Options(
      headers: {
        'Authorization': 'Bearer $token',
      },
    ));

    return response.statusCode == 200;
  }

  Future<bool> unfavoriteMenuItem(int id, String token) async {
    var response = await dio.delete("$BASE_URL/menu/${id}/favorite", options: Options(
      headers: {
        'Authorization': 'Bearer $token',
      },
    ));

    return response.statusCode == 200;
  }
}