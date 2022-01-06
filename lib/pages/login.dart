import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taneo/components/app_buttons.dart';
import 'package:taneo/components/app_text.dart';
import 'package:taneo/components/app_textfield.dart';
import 'package:taneo/components/socials_login.dart';
import 'package:taneo/pages/home.dart';
import 'package:taneo/pages/signup.dart';
import 'package:taneo/style.dart';
import 'package:taneo/util/validation.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FocusNode _f1 = FocusNode();
  final FocusNode _f2 = FocusNode();

  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool visible = false;

  void callback() {
    setState(() {
      _f1.unfocus();
      _f2.unfocus();
    });
  }

  @override
  void dispose() {
    _f1.dispose();
    _f2.dispose();
    super.dispose();
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
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: Style.height / 23),
                    AppText.header('Login to your account'),
                    SizedBox(height: Style.height / 60),
                    const SocialsLogin(),
                    SizedBox(height: Style.height / 90),
                    AppText.body('or login with email'),
                    SizedBox(height: Style.height / 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            suggestion: 'Email or username',
                            focusNode: _f1,
                            callback: callback,
                            validator: Validation.emailUserValidator,
                            controller: _controller1,
                          ),
                          SizedBox(height: Style.height / 60),
                          CustomTextField(
                            suggestion: 'Password',
                            focusNode: _f2,
                            callback: callback,
                            validator: Validation.passwordValidator,
                            isPassword: true,
                            controller: _controller2,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        SecondaryButton(
                            callback: () {},
                            grayText: '',
                            actionText: 'Forgot password?'
                        ),
                        SizedBox(width: Style.width / 6 - 9),
                      ]
                    ),
                    if (visible) const SizedBox(height: 5),
                    if (visible) AppText.error('Please fill out the missing fields'),
                    const Spacer(),
                    PrimaryButton(callback: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const Home()
                            ),
                            (route) => false,
                        );
                      } else {
                        setState(() {
                          visible = true;
                        });
                      }
                    }, text: 'LOGIN'),
                    SizedBox(height: Style.height / 50),
                    SecondaryButton(callback: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const Signup()
                          ),
                          ModalRoute.withName('/')
                      );
                    }, grayText: 'Don\'t have an account?', actionText: 'Sign up here'
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
