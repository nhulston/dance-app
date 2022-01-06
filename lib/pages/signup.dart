import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taneo/components/app_buttons.dart';
import 'package:taneo/components/app_text.dart';
import 'package:taneo/components/app_textfield.dart';
import 'package:taneo/components/email_code_popup.dart';
import 'package:taneo/components/socials_login.dart';
import 'package:taneo/style.dart';
import 'package:taneo/util/validation.dart';

import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  SignupState createState() => SignupState();
}

class SignupState extends State<Signup> {
  final FocusNode _f1 = FocusNode();
  final FocusNode _f2 = FocusNode();
  final FocusNode _f3 = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  
  bool _visible = false;
  bool _openedDialog = false;
  static String? email;

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
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void toggleOpenedDialog() {
    setState(() {
      _openedDialog = !_openedDialog;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: !_openedDialog,
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
              top: Style.height / 8,
              left: 0,
              child: Image.asset(
                'assets/background_overlays/lines.png',
                width: Style.width * .2,
              ),
            ),
            Positioned(
              top: Style.height / 3 - Style.width * .23,
              right: 20,
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
              top: 20,
              left: Style.width * .2,
              width: Style.width * .6,
              child: Image.asset('assets/dancing.png', height: Style.width / 1.5),
            ),
            Positioned(
              left: 15,
              top: MediaQuery.of(context).padding.top,
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
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: Style.height / 23),
                    AppText.header('Create New Account'),
                    SizedBox(height: Style.height / 60),
                    const SocialsLogin(),
                    SizedBox(height: Style.height / 90),
                    AppText.body('or sign up with email'),
                    SizedBox(height: Style.height / 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            suggestion: 'Email',
                            focusNode: _f1,
                            callback: callback,
                            validator: Validation.emailValidator,
                            controller: _emailController,
                          ),
                          SizedBox(height: Style.height / 60),
                          CustomTextField(
                            suggestion: 'Username',
                            focusNode: _f2,
                            callback: callback,
                            validator: Validation.usernameValidator,
                            controller: _usernameController,
                          ),
                          SizedBox(height: Style.height / 60),
                          CustomTextField(
                            suggestion: 'Password',
                            focusNode: _f3,
                            callback: callback,
                            validator: Validation.passwordValidator,
                            controller: _passwordController,
                            isPassword: true,
                          ),
                        ],
                      ),
                    ),
                    if (_visible) const SizedBox(height: 5),
                    if (_visible) AppText.error('Please fill out the missing fields'),
                    const Spacer(),
                    PrimaryButton(callback: () {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _visible = false;
                          toggleOpenedDialog();
                        });
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return EmailCodePopup(email: _emailController.text, goBackCallback: toggleOpenedDialog);
                          }
                        );
                      } else {
                        setState(() {
                          _visible = true;
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
