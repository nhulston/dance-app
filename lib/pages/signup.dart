import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taneo/components/app_buttons.dart';
import 'package:taneo/components/app_text.dart';
import 'package:taneo/components/app_textfield.dart';
import 'package:taneo/components/socials_login.dart';
import 'package:taneo/style.dart';

import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FocusNode _f1 = FocusNode();
  final FocusNode _f2 = FocusNode();
  final FocusNode _f3 = FocusNode();

  final _formKey = GlobalKey<FormState>();
  
  bool visible = false;

  void callback() {
    setState(() {
      _f1.unfocus();
      _f2.unfocus();
      _f3.unfocus();
    });
  }

  @override
  void dispose() {
    _f1.dispose();
    _f2.dispose();
    _f3.dispose();
    super.dispose();
  }

  bool emailValidator(String? s) {
    if (s == null || s.isEmpty || s.length < 6 || !s.contains('@') || !s.contains('.')) {
      return false;
    }
    return true;
  }

  bool usernameValidator(String? s) {
    if (s == null || s.length < 3) {
      return false;
    }
    return true;
  }

  bool passwordValidator(String? s) {
    if (s == null || s.length < 6) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Style.white,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: Style.height,
                width: Style.width,
                color: Style.accent,
              ),
            ),
            Positioned(
              top: -10 + MediaQuery.of(context).padding.bottom,
              left: Style.width * .2,
              width: Style.width * .6,
              child: Image.asset('assets/salsa.png'),
            ),
            Positioned(
              left: 15,
              top: MediaQuery.of(context).padding.bottom,
              child: IconButton(
                icon: const Icon(CupertinoIcons.back, size: 32, color: Style.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: Style.height * 2 / 3,
              child: Card(
                margin: EdgeInsets.zero,
                color: Style.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: Style.height / 23),
                    AppText.header('Create New Account'),
                    SizedBox(height: Style.height / 60),
                    const SocialsLogin(),
                    SizedBox(height: Style.height / 90),
                    AppText.gray('or sign up with email'),
                    SizedBox(height: Style.height / 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            suggestion: 'Email',
                            focusNode: _f1,
                            callback: callback,
                            validator: emailValidator,
                          ),
                          SizedBox(height: Style.height / 60),
                          CustomTextField(
                            suggestion: 'Username',
                            focusNode: _f2,
                            callback: callback,
                            validator: usernameValidator,
                          ),
                          SizedBox(height: Style.height / 60),
                          CustomTextField(
                            suggestion: 'Password',
                            focusNode: _f3,
                            callback: callback,
                            validator: passwordValidator,
                            isPassword: true,
                          ),
                        ],
                      ),
                    ),
                    if (visible) const SizedBox(height: 5),
                    if (visible) AppText.error('Please fill out the missing fields'),
                    const Spacer(),
                    PrimaryButton(callback: () {
                      if (_formKey.currentState!.validate()) {
                        print('valid');
                      } else {
                        print('not valid');
                        setState(() {
                          visible = true;
                        });
                      }
                    }, text: 'REGISTER'),
                    SizedBox(height: Style.height / 50),
                    SecondaryButton(callback: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const Login()
                        ),
                        ModalRoute.withName('/')
                      );
                    }, grayText: 'Already have an account?', actionText: 'Login here'
                    ),
                    SizedBox(height: 10 + MediaQuery.of(context).padding.bottom),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
