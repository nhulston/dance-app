import 'package:flutter/material.dart';
import 'package:taneo/components/app_buttons.dart';
import 'package:taneo/components/app_text.dart';
import 'package:taneo/pages/login.dart';
import 'package:taneo/pages/signup.dart';
import '../style.dart';

class FirstLogin extends StatefulWidget {
  const FirstLogin({Key? key}) : super(key: key);

  @override
  _FirstLoginState createState() => _FirstLoginState();
}

class _FirstLoginState extends State<FirstLogin> {
  @override
  Widget build(BuildContext context) {
    Style.height = MediaQuery.of(context).size.height;
    Style.width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Style.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Style.height / 12),
              const Text('Logo Goes Here', textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic)),
              SizedBox(height: Style.height / 25),
              Image.asset('assets/salsa.png', width: Style.width / 1.5),
              SizedBox(height: Style.height / 15),
              AppText.header('Put on your dancing shoes'),
              const SizedBox(height: 10),
              AppText.body('Create an account to access hundreds\nof free exercise videos'),
              const Spacer(),
              PrimaryButton(callback: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Signup()));
              }, text: 'REGISTER'),
              SizedBox(height: Style.height / 50),
              SecondaryButton(callback: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Login()));
              }, grayText: 'Already have an account?', actionText: 'Login here'),
              const SizedBox(height: 10),
            ],
          ),
        )
      ),
    );
  }
}
