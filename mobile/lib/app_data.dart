import 'package:shared_preferences/shared_preferences.dart';

class AppData {
  String? token;

  AppData({this.token});
}

Future<AppData> loadFromSharedPreferences() async {
  var prefs = await SharedPreferences.getInstance();

  return AppData(
    token: prefs.getString("token"),
  );
}