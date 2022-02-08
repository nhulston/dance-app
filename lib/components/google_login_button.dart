import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taneo/components/app_text.dart';
import 'package:taneo/pages/home.dart';
import 'package:taneo/pages/pick_experience.dart';
import 'package:taneo/util/authentication_service.dart';
import 'package:taneo/util/style.dart';

class GoogleLoginButton extends StatefulWidget {
  const GoogleLoginButton({
    Key? key,
    required this.signUp,
  }) : super(key: key);

  final bool signUp;

  @override
  _GoogleLoginButtonState createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends State<GoogleLoginButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        int loggedIn = await context.read<AuthenticationService>().googleLogin();
        bool firstTime = loggedIn == 1;
        if (loggedIn != 0) {
          log('Google log in successful');
          log('First time logging in w/ Google: $firstTime');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => firstTime ? const PickExperience() : const Home(),
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
              AppText.body('${widget.signUp ? 'Sign up' : 'Sign in'} with Google'),
            ],
          ),
        ),
      ),
    );
  }
}
