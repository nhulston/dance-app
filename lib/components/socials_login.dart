import 'package:flutter/material.dart';
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
        LoginWith(callback: () {}, imageName: 'google'),
        const SizedBox(width: 10),
        if (Platform.isIOS) LoginWith(callback: () {}, imageName: 'apple'),
        if (Platform.isIOS) const SizedBox(width: 10),
        LoginWith(callback: () {}, imageName: 'facebook'),
      ],
    );
  }
}
