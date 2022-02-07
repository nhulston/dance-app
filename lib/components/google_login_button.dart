import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taneo/components/app_text.dart';
import 'package:taneo/pages/home.dart';
import 'package:taneo/util/authentication_service.dart';
import 'package:taneo/util/style.dart';

class GoogleLoginButton extends StatefulWidget {
  const GoogleLoginButton({Key? key}) : super(key: key);

  @override
  _GoogleLoginButtonState createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends State<GoogleLoginButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool loggedIn = await context.read<AuthenticationService>()
            .googleLogin();
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
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(.2), width: 1),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Style.white,
                radius: Style.width / 17,
                child: Image.asset(
                  'assets/google.png',
                  width: Style.width / 13,
                  height: Style.width / 13,
                ),
              ),
              const SizedBox(width: 10),
              AppText.body('Sign in with Google'),
            ],
          ),
        ),
      ),
    );
  }
}
