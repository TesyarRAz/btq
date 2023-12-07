import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppData {
  String? token;
  GoogleSignInAccount? googleAccount;

  AppData({
    this.token,
    this.googleAccount,
  });
}

Future<AppData> loadFromAppData() async {
  var prefs = await SharedPreferences.getInstance();
  var googleAccount = await GoogleSignIn(
    scopes: ['openid', 'email', 'profile'],
  ).signInSilently();

  return AppData(
    token: prefs.getString("token"),
    googleAccount: googleAccount,
  );
}
