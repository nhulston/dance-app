import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:taneo/components/app_buttons.dart';
import 'package:taneo/components/app_text.dart';
import 'package:taneo/pages/home.dart';
import 'package:taneo/util/style.dart';

class EmailPopup extends StatefulWidget {
  const EmailPopup({
    Key? key,
    required this.email,
    required this.goBackCallback,
  }) : super(key: key);
  final String email;
  final VoidCallback goBackCallback;

  @override
  _EmailPopupState createState() => _EmailPopupState();
}

class _EmailPopupState extends State<EmailPopup> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Stack(
        children: [
          SizedBox(height: Style.height / 25),
          Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            elevation: 16,
            backgroundColor: Style.accent,
            child: SizedBox(
              height: Style.height * 2 / 3,
              child: Stack(
                children: [
                  Positioned(
                    top: Style.height / 13,
                    left: -5,
                    child: Image.asset(
                      'assets/background_overlays/lines.png',
                      width: Style.width * .29,
                    ),
                  ),
                  Positioned(
                    top: Style.height / 6.5,
                    right: 10,
                    child: Transform.rotate(
                      angle: -.2,
                      child: Image.asset(
                        'assets/background_overlays/note.png',
                        color: Colors.black.withOpacity(.1),
                        width: Style.width * .15,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    right: 0,
                    child: Image.asset(
                      'assets/background_overlays/white.png',
                      color: Colors.white.withOpacity(.08),
                      width: Style.width * .45,
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    right: 0,
                    child: Image.asset(
                      'assets/background_overlays/black.png',
                      color: Colors.black.withOpacity(.1),
                      width: Style.width * .45,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(Style.height / 30, 0, Style.height / 30, 0),
                    child: Column(
                      children: [
                        const Spacer(flex: 3),
                        Image.asset('assets/email.png', width: Style.width / 4),
                        const Spacer(flex: 2),
                        AppText.header('Almost there!', Style.white),
                        const SizedBox(height: 10),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: AppText.bodyStyle(Style.white),
                              children: [
                                const TextSpan(text: 'We\'re glad you\'re joining us! Before moving on, please verify your email: '),
                                TextSpan(text: widget.email, style: const TextStyle(fontWeight: FontWeight.bold)),
                              ]
                          ),
                        ),
                        const Spacer(flex: 3),
                        BlackButton(callback: () {
                          log('Sign up completed. Going to home');
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ),
                            ModalRoute.withName('/Home')
                          );
                        }, text: 'Complete Sign Up'),
                        Row(
                          children: [
                            SecondaryButton(callback: () {
                              widget.goBackCallback();
                              Navigator.of(context).pop();
                            }, grayText: '', actionText: 'Change email', color: Style.white), // TODO
                            const SizedBox(width: 5),
                            const Spacer(),
                          ],
                        ),
                        const Spacer(flex: 2),
                      ],
                    ),
                  ),
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}
