import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taneo/pages/home.dart';
import 'package:taneo/util/authentication_service.dart';
import 'dart:io' show Platform;
import 'app_buttons.dart';

class SocialsLogin extends StatefulWidget {
  const SocialsLogin({Key? key}) : super(key: key);

  @override
  _SocialsLoginState createState() => _SocialsLoginState();
}

class _SocialsLoginState extends State<SocialsLogin> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoginWith(callback: () async {
          bool loggedIn = await context.read<AuthenticationService>().googleLogin();
          if (loggedIn) {
            log('Google log in successful');
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const Home()
                ),
                ModalRoute.withName('/Home')
            );
          } else {
            log('Google log in failed. Maybe user cancelled login?');
          }

        }, imageName: 'google'),
        const SizedBox(width: 10),
        if (Platform.isIOS) LoginWith(callback: () {}, imageName: 'apple'),
        if (Platform.isIOS) const SizedBox(width: 10),
        LoginWith(callback: () {}, imageName: 'facebook'),
      ],
    );
  }
}
