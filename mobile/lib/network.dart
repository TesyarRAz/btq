import 'dart:convert';

import 'package:bacaanshalat/model/menu.dart';
import 'package:bacaanshalat/model/menu_item.dart';
import 'package:bacaanshalat/model/user.dart';
import 'package:dio/dio.dart';

class Network {
  static String baseUrl = "https://btq.tesyarraz.my.id";

  Network._();

  static Network? _instance;

  static Network get instance {
    _instance ??= Network._();

    return _instance!;
  }

  final dio = Dio(
    BaseOptions(
      responseType: ResponseType.json,
      baseUrl: baseUrl,
    ),
  );

  Future<String?> getUserDataFromProviderToken(String providerToken) async {
    var response = await dio.get("/social/google/login", queryParameters: {
      "access_token": providerToken,
    });

    if (response.statusCode == 200) {
      return response.data['token'];
    }

    return null;
  }

  Future<User?> getUserData(String token) async {
    var response = await dio.get("/api/user", options: Options(
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

    var response = await dio.get("/api/menu",
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
    var response = await dio.get("/api/menu/favorites",
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
    var response = await dio.post("/api/menu/$id/favorite",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ));

    return response.statusCode == 200;
  }

  Future<bool> unfavoriteMenuItem(int id, String token) async {
    var response = await dio.delete("/api/menu/$id/favorite",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ));

    return response.statusCode == 200;
  }
}
