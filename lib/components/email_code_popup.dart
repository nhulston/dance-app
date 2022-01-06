import 'package:flutter/material.dart';
import 'package:taneo/components/app_buttons.dart';
import 'package:taneo/components/app_text.dart';
import 'package:taneo/components/verification_code.dart';
import 'package:taneo/pages/paywall.dart';
import 'package:taneo/style.dart';

class EmailCodePopup extends StatefulWidget {
  const EmailCodePopup({
    Key? key,
    required this.email,
    required this.goBackCallback,
  }) : super(key: key);
  final String email;
  final VoidCallback goBackCallback;

  @override
  _EmailCodePopupState createState() => _EmailCodePopupState();
}

class _EmailCodePopupState extends State<EmailCodePopup> {
  String? _code;
  bool _editing = false;

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
                        VerificationCode(
                          itemSize: Style.width / 10,
                          length: 5,
                          digitsOnly: true,
                          textStyle: const TextStyle(fontSize: 20.0, color: Style.white),
                          underlineColor: Style.white,
                          underlineUnfocusedColor: Colors.grey.shade600,
                          keyboardType: TextInputType.number,
                          clearAll: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'clear all',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Style.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          onCompleted: (String value) {
                            setState(() {
                              _code = value;
                            });
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const Paywall()
                              ),
                                  (route) => false,
                            );
                          },
                          onEditing: (bool value) {
                            setState(() {
                              _editing = value;
                            });
                          },
                        ),
                        const Spacer(flex: 1),
                        BlackButton(callback: () {}, text: 'Resend email confirmation'),
                        Row(
                          children: [
                            SecondaryButton(callback: () {
                              widget.goBackCallback();
                              Navigator.of(context).pop();
                            }, grayText: '', actionText: 'Change email', color: Style.white),
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
