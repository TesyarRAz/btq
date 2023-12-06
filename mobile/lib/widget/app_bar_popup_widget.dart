import 'package:bacaanshalat/page/user_page.dart';
import 'package:bacaanshalat/provider/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarPopupWidget extends StatelessWidget {
  const AppBarPopupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context, listen: false);

    return PopupMenuButton<String>(
      itemBuilder: (context) {
        return [
          const PopupMenuItem<String>(
            value: 'user',
            child: Text('User'),
          ),
        ];
      },
      onSelected: (value) {
        if (value == 'user') {
          Navigator.of(context).pushNamed(UserPage.route);
        }
      },
    );
  }
}
