import 'package:bacaanshalat/app_data.dart';
import 'package:bacaanshalat/page/main_page.dart';
import 'package:bacaanshalat/page/user_page.dart';
import 'package:bacaanshalat/provider/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var appData = await loadFromAppData();
  var userModel = UserModel();
  userModel.token = appData.token;
  await userModel.setGoogleAccount(appData.googleAccount);

  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: appData),
        ChangeNotifierProvider(create: (_) => userModel),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        MainPage.route: (_) => const MainPage(),
        UserPage.route: (_) => const UserPage(),
      },
    );
  }
}
