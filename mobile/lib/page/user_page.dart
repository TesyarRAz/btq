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
  GoogleSignInAccount? _currentUser;

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text(_currentUser == null ? 'Login' : 'Logout'),
          onPressed: () async {
            if (_currentUser == null) {
              _signIn(userModel);
            } else {
              _signOut(userModel);
            }
          },
        ),
      ),
    );
  }

  Future<void> _signIn(UserModel userModel) async {
    final auth = await _googleSignIn.signIn();

    if (auth != null) {
      Network.instance.
    }

    setState(() {
      _currentUser = auth;
    });
  }

  Future<void> _signOut(UserModel userModel) async {
    final auth = await _googleSignIn.signOut();

    setState(() {
      _currentUser = auth;
    });
  }
}
