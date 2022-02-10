import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:taneo/pages/first_login.dart';
import 'package:taneo/pages/home.dart';
import 'package:taneo/pages/pick_experience.dart';
import 'package:taneo/util/authentication_service.dart';
import 'package:taneo/util/preferences.dart';
import 'package:taneo/util/style.dart';

/*
  TODO list
  - unhide password
  - show paywall if free every 50 log ins or something like that
  - cool loading page instead of CircularProgressIndicator.adaptive
  - Search tab - show recent searches when search bar is empty
  - Credit flaticon in settings
  - Ask user to update
 */

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Preferences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseApp,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          log('[MyApp build] Firebase init has some error');
          return MaterialApp(
            builder: (context, widget) {
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(100),
                  child: Center(child: Text('Something went wrong: \n${snapshot.error.toString()}')),
                ),
              );
            },
          );
        } else if (snapshot.hasData) {
          log('[MyApp build] Firebase init has data');
          return MultiProvider(
            providers: [
              Provider<AuthenticationService>(
                create: (_) => AuthenticationService(FirebaseAuth.instance),
              ),
              StreamProvider(
                create: (context) => context.read<AuthenticationService>().authStateChanges,
                initialData: null,
              ),
            ],
            child: MaterialApp(
              theme: ThemeData(
                fontFamily: 'Roboto',
                canvasColor: Style.white,
                brightness: Brightness.light,
                appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarBrightness: Brightness.light,
                  ),
                ),
                textTheme: const TextTheme(
                  bodyText2: TextStyle(fontSize: Style.bodyFontSize),
                  button: TextStyle(fontSize: Style.bodyFontSize),
                ),
              ),
              builder: (context, widget) {
                return ScrollConfiguration(
                    behavior: const ScrollBehaviorModified(), child: widget!
                );
              },
              home: const AuthenticationWrapper(),
            ),
          );
        } else {
          log('[MyApp build] Firebase is loading...');
          return MaterialApp(
            builder: (context, widget) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            },
          );
        }
      }
    );
  }
}

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? firebaseUser = context.watch<User?>();

    // Logged in
    if (firebaseUser != null) {
      AuthenticationService.email = firebaseUser.email;

      log('[AuthWrapper build] Experience level: ${Preferences.getExperienceLevel()}');
      if (Preferences.getExperienceLevel() == -1) {
        return const PickExperience();
      } else {
        return const Home();
      }
    }

    // Not logged in
    return const FirstLogin();
  }
}
