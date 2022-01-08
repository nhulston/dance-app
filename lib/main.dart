import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taneo/pages/first_login.dart';
import 'package:taneo/util/style.dart';

/*
  TODO list
  - Change images for login and register page
  - Forgot password button
  - animate keyboard open
  - unhide password
 */

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Roboto',
        canvasColor: Style.white,
        brightness: Brightness.light,
        textTheme: const TextTheme(
          bodyText2: TextStyle(fontSize: Style.bodyFontSize),
          button: TextStyle(fontSize: Style.bodyFontSize),
        ),
      ),
      home: const FirstLogin(),
    );
  }
}