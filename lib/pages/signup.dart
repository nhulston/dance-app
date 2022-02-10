import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:taneo/components/app_buttons.dart';
import 'package:taneo/components/app_text.dart';
import 'package:taneo/components/app_textfield.dart';
import 'package:taneo/components/back_arrow.dart';
import 'package:taneo/components/email_popup.dart';
import 'package:taneo/components/google_login_button.dart';
import 'package:taneo/util/authentication_service.dart';
import 'package:taneo/util/style.dart';
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

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  
  bool _missingFieldsVisible = false;
  bool _emailTakenVisible = false;
  bool _openedDialog = false;
  bool _textChanged = false;
  bool _noWifiVisible = false;

  void callback() {
    setState(() {
      _f1.unfocus();
      _f2.unfocus();
    });
  }

  void editCallback() {
    _textChanged = true;
  }

  @override
  void dispose() {
    _f1.dispose();
    _f2.dispose();
    _emailController.dispose();
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
    AuthenticationService.connected().then((value) => _noWifiVisible = !value);
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
              top: Style.height / 8 + 20,
              left: 0,
              child: Image.asset(
                'assets/background_overlays/lines.png',
                width: Style.width * .2,
              ),
            ),
            Positioned(
              top: Style.height / 3 - Style.width * .23 + 20,
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
              top: 40,
              left: Style.width * .2,
              width: Style.width * .6,
              child: Image.asset('assets/dancing.png', height: Style.width / 1.5),
            ),
            const BackArrow(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: Style.height * .62,
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
                    const GoogleLoginButton(signUp: true),
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
                            editCallback: editCallback, // TODO
                            validator: Validation.emailValidator,
                            controller: _emailController,
                            isEmail: true,
                          ),
                          SizedBox(height: Style.height / 60),
                          CustomTextField(
                            suggestion: 'Password',
                            focusNode: _f2,
                            callback: callback,
                            editCallback: editCallback, // TODO
                            validator: Validation.passwordValidator,
                            controller: _passwordController,
                            isPassword: true,
                          ),
                        ],
                      ),
                    ),
                    if (_missingFieldsVisible || _emailTakenVisible || _noWifiVisible) const SizedBox(height: 5),
                    if (_noWifiVisible) AppText.error('You are not connected to the internet'),
                    if (!_noWifiVisible && _missingFieldsVisible) AppText.error('Please fill out the missing fields.'),
                    if (!_noWifiVisible && _emailTakenVisible) AppText.error('An account with this email already exists.'),
                    const Spacer(),
                    PrimaryButton(callback: () async {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        if (_textChanged) {
                          bool signupSuccessful = await context.read<AuthenticationService>().signUpWithEmail(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );

                          if (signupSuccessful) {
                            setState(() {
                              _missingFieldsVisible = false;
                              _emailTakenVisible = false;
                              toggleOpenedDialog();
                            });

                            showCupertinoDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return EmailPopup(email: _emailController.text, goBackCallback: toggleOpenedDialog);
                              }
                            );
                          } else {
                            _textChanged = false;
                            setState(() {
                              _missingFieldsVisible = false;
                              _emailTakenVisible = true;
                            });
                          }
                        }
                      } else {
                        setState(() {
                          _missingFieldsVisible = true;
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
