import 'package:bacaanshalat/app_data.dart';
import 'package:bacaanshalat/model/user.dart';
import 'package:bacaanshalat/network.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel extends ChangeNotifier {
  User? _user;
  String? _token;

  UserModel(AppData appData) {
    _token = appData.token;

    _loadUserData();
  }

  set user(User? value) {
    if (_user != value) {
      _user = value;
      notifyListeners();
    }
  }

  set token(String? value) {
    if (_token != value) {
      _token = value;
      SharedPreferences.getInstance().then((prefs) {
        if (value != null) {
          prefs.setString("token", value);
        } else {
          prefs.remove("token");
        }
      });
      notifyListeners();
    }
  }

  Future<void> _loadUserData() async {
    if (token != null) {
      user = await Network.instance.getUserData(token!);
    }
  }

  User? get user => _user;
  String? get token => _token;
  bool get isLoggedIn => user != null && token != null;
}