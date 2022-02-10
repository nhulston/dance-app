import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taneo/components/app_text.dart';
import 'package:taneo/pages/home.dart';
import 'package:taneo/pages/pick_experience.dart';
import 'package:taneo/util/authentication_service.dart';
import 'package:taneo/util/style.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({
    Key? key,
    required this.signUp,
  }) : super(key: key);

  final bool signUp;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool? firstTime = await context.read<AuthenticationService>().googleLogin();
        if (firstTime != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => firstTime ? const PickExperience() : const Home(),
              ),
              ModalRoute.withName('/Home')
          );
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
              AppText.body('${signUp ? 'Sign up' : 'Sign in'} with Google'),
            ],
          ),
        ),
      ),
    );
  }
}