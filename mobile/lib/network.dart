import 'dart:convert';

import 'package:bacaanshalat/model/menu.dart';
import 'package:bacaanshalat/model/menu_item.dart';
import 'package:bacaanshalat/model/user.dart';
import 'package:dio/dio.dart';

class Network {
  static String baseUrl = "http://172.28.16.1:8000/api";

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

  Future<String> getUserToken(String providerToken) async {
    var response = await dio.get("$baseUrl/social/google/login", );
  }

  Future<User?> getUserData(String token) async {
    var response = await dio.get("$baseUrl/user", options: Options(
      headers: {
        'Authorization': 'Bearer $token',
      },
    ));

    if (response.statusCode == 200) {
      return User.fromJson(response.data['user']);
    }

    return null;
  }

  Future<List<Menu>> getMenu([String? token]) async {
    Map<String, dynamic> headers = {};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    var response = await dio.get("$baseUrl/menu",
        options: Options(
          headers: headers,
        ));

    if (response.statusCode == 200) {
      return (response.data['data'] as List<dynamic>)
          .map((e) => Menu.fromJson(e))
          .toList();
    }

    return [];
  }

  Future<List<Menu>> getFavoritesMenu(String token) async {
    var response = await dio.get("$baseUrl/menu/favorites",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ));

    if (response.statusCode == 200) {
      return (response.data['data'] as List<dynamic>)
          .map((e) => Menu.fromJson(e))
          .toList();
    }

    return [];
  }

  Future<bool> favoriteMenuItem(int id, String token) async {
    var response = await dio.post("$baseUrl/menu/$id/favorite",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ));

    return response.statusCode == 200;
  }

  Future<bool> unfavoriteMenuItem(int id, String token) async {
    var response = await dio.delete("$baseUrl/menu/$id/favorite",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ));

    return response.statusCode == 200;
  }
}
