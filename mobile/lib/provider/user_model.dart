import 'package:bacaanshalat/app_data.dart';
import 'package:bacaanshalat/model/user.dart';
import 'package:bacaanshalat/network.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel extends ChangeNotifier {
  GoogleSignInAccount? _googleAccount;
  User? _user;
  String? _token;

  UserModel(AppData appData) {
    _token = appData.token;
    _googleAccount = appData.googleAccount;

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

  Future<void> setGoogleAccount(GoogleSignInAccount? value) async {
    if (_googleAccount != value) {
      _googleAccount = value;
      if (_googleAccount == null) {
        user = null;
        token = null;
      } else {
        await _loadUserData();
      }
      notifyListeners();
    }
  }

  Future<void> _loadUserData() async {
    if (_googleAccount != null) {
      var providerToken = (await _googleAccount!.authentication).accessToken;
      if (providerToken == null) return;

      var accessToken = await Network.instance.getUserDataFromProviderToken(providerToken);
      if (accessToken == null) return;

      token = accessToken;

      var user = await Network.instance.getUserData(accessToken);
      if (user == null) return;

      user = user;
    }

    if (token != null) {
      user = await Network.instance.getUserData(token!);
    }
  }

  User? get user => _user;
  String? get token => _token;
  GoogleSignInAccount? get googleAccount => _googleAccount;
  bool get isLoggedIn => user != null && token != null;
}