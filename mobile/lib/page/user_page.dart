import 'package:bacaanshalat/network.dart';
import 'package:bacaanshalat/provider/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  static const route = "/user";

  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _googleSignIn = GoogleSignIn(
    scopes: ['openid', 'email', 'profile'],
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (userModel.user != null) ...[
              Text("Nama : ${userModel.user!.name}"),
              Text("Email : ${userModel.user!.email}"),
            ],
            ElevatedButton(
              child: Text(userModel.googleAccount == null ? 'Login' : 'Logout'),
              onPressed: () async {
                if (userModel.googleAccount == null) {
                  _signIn(userModel);
                } else {
                  _signOut(userModel);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signIn(UserModel userModel) async {
    final auth = await _googleSignIn.signIn();
    if (auth == null) return;

    userModel.googleAccount = auth;
  }

  Future<void> _signOut(UserModel userModel) async {
    final auth = await _googleSignIn.signOut();

    userModel.user = null;
    userModel.token = null;

    userModel.googleAccount = auth;
  }
}
