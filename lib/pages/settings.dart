import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:taneo/components/app_text.dart';
import 'package:taneo/components/app_textfield.dart';
import 'package:taneo/components/popup.dart';
import 'package:taneo/pages/first_login.dart';
import 'package:taneo/pages/pick_experience.dart';
import 'package:taneo/util/authentication_service.dart';
import 'package:taneo/util/preferences.dart';
import 'package:taneo/util/style.dart';
import 'package:taneo/util/validation.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: false,
            floating: true,
            snap: false,
            iconTheme: IconThemeData(
              color: Style.black,
            ),
            title: Text(
              'Settings',
              style: TextStyle(color: Style.black),
            ),
            backgroundColor: Style.white,
            elevation: 3,
            forceElevated: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.fromLTRB(Style.width / 12, 0, Style.width / 12, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        AppText.header('Account', Style.black, 0.9),
                        const SizedBox(height: 5),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            showCupertinoDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) => Popup(
                                title: 'Change email',
                                content:
                                const Text('Are you sure you want to change your email?'),
                                okCallback: () {
                                  bool _hasWifi = true;
                                  AuthenticationService.connected().then((value) => _hasWifi = value);
                                  final TextEditingController _passwordController = TextEditingController();
                                  Navigator.of(context).pop();
                                  showCupertinoDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => Popup(
                                        title: 'Confirm password',
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text('Please confirm your current password'),
                                            const SizedBox(height: 20),
                                            CustomTextField(
                                              suggestion: 'Password',
                                              focusNode: FocusNode(),
                                              callback: () {},
                                              editCallback: () {},
                                              validator: Validation.passwordValidator,
                                              controller: _passwordController,
                                              isPassword: true,
                                            ),
                                          ],
                                        ),
                                        okCallback: () async {
                                          AuthCredential credential = EmailAuthProvider.credential(
                                            email: AuthenticationService.email!,
                                            password: _passwordController.text,
                                          );
                                          await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(credential).then((value) {
                                            Navigator.of(context).pop();
                                            final TextEditingController _emailController = TextEditingController();
                                            bool _changed = true;
                                            showCupertinoDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) => Popup(
                                                  title: 'Enter email',
                                                  content: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      const Text('What email do you want to switch to?'),
                                                      const SizedBox(height: 20),
                                                      CustomTextField(
                                                        suggestion: 'Email',
                                                        focusNode: FocusNode(),
                                                        callback: () {},
                                                        editCallback: () {
                                                          _changed = true;
                                                        },
                                                        validator: Validation.emailValidator,
                                                        controller: _emailController,
                                                        isEmail: true,
                                                      ),
                                                    ],
                                                  ),
                                                  okCallback: () async {
                                                    if (_changed && Validation.emailValidator(_emailController.text)) {
                                                      await FirebaseAuth.instance.currentUser!.updateEmail(_emailController.text).then((value) {
                                                        Navigator.of(context).pop();
                                                        setState(() {
                                                          AuthenticationService.email = FirebaseAuth.instance.currentUser!.email;
                                                        });
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(
                                                            content: Text('Email successfully changed to ${_emailController.text}'),
                                                            action: SnackBarAction(
                                                                label: 'Dismiss',
                                                                onPressed: () {}
                                                            ),
                                                          ),
                                                        );
                                                      }).catchError((error) {
                                                        _changed = false;
                                                        String errorMsg = error.toString().substring(error.toString().indexOf(']') + 2);
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(
                                                            content: Text(errorMsg),
                                                            action: SnackBarAction(
                                                                label: 'Dismiss',
                                                                onPressed: () {}
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                    }
                                                  }
                                              ),
                                            );
                                          }).catchError((error) {
                                            if (Validation.passwordValidator(_passwordController.text)) {
                                              Navigator.of(context).pop();
                                              late String _message;
                                              if (_hasWifi) {
                                                _message = 'Invalid password. Please try again.';
                                              } else {
                                                _message = 'You are not connected to wifi. Please try again.';
                                              }
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(_message),
                                                  action: SnackBarAction(
                                                      label: 'Dismiss',
                                                      onPressed: () {}
                                                  ),
                                                ),
                                              );
                                            }
                                          });
                                        }
                                    ),
                                  );
                                }
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.boldSubtext('Change Email'),
                              AppText.body(AuthenticationService.email ?? 'Unknown email'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            showCupertinoDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) => Popup(
                                title: 'Reset password',
                                content: const Text('Are you sure you want to reset your password?'),
                                okCallback: () async {
                                  late String _message;
                                  await FirebaseAuth.instance.sendPasswordResetEmail(email: AuthenticationService.email ?? '')
                                    .then((value) => _message = 'Password reset sent to ${AuthenticationService.email ?? 'error'}')
                                    .catchError((onError) => _message = 'Some error occurred. Are you connected to wifi?');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(_message),
                                      action: SnackBarAction(
                                          label: 'Dismiss',
                                          onPressed: () {}
                                      ),
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                }
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.boldSubtext('Change Password'),
                              AppText.body('*********'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Divider(thickness: .6, color: Style.gray),
                        const SizedBox(height: 20),

                        AppText.header('Skill Level', Style.black, 0.9),
                        const SizedBox(height: 5),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) =>
                                PickExperience(callback: () {
                                  setState(() {});
                                }),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.boldSubtext('Change Skill Level'),
                              AppText.body(Preferences.getExperienceLevelString()),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Divider(thickness: .6, color: Style.gray),
                        const SizedBox(height: 20),

                        AppText.header('Manage Plan', Style.black, 0.9),
                        const SizedBox(height: 5),
                        AppText.boldSubtext('Current Plan'),
                        AppText.body('Premium'),
                        const SizedBox(height: 10),
                        AppText.boldSubtext('Remaining Days in Billing Cycle'),
                        AppText.body('21 days'),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {},
                          child: AppText.boldSubtext('Upgrade or Cancel Plan'),
                        ),
                        const SizedBox(height: 5),
                        const Divider(thickness: .6, color: Style.gray),
                        const SizedBox(height: 20),

                        AppText.header('About', Style.black, 0.9),
                        const SizedBox(height: 5),
                        AppText.boldSubtext('Version'),
                        AppText.body('1.0'),
                        const SizedBox(height: 10),
                        AppText.boldSubtext('Terms and Conditions'),
                        AppText.body('Everything you need to know'),
                        const SizedBox(height: 10),
                        AppText.boldSubtext('Privacy Policy'),
                        AppText.body('We value your privacy'),
                        const SizedBox(height: 10),
                        AppText.boldSubtext('Support'),
                        AppText.body('Get help from us'),
                        const SizedBox(height: 5),
                        const Divider(thickness: .6, color: Style.gray),
                        const SizedBox(height: 20),

                        AppText.header('Other', Style.black, 0.9),
                        const SizedBox(height: 5),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            showCupertinoDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) => Popup(
                                title: 'Confirm log out',
                                content: const Text('Are you sure you want to log out?'),
                                okCallback: () {
                                  context.read<AuthenticationService>().logOut();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const FirstLogin()
                                    ),
                                    ModalRoute.withName('/Home')
                                  );
                                },
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.boldSubtext('Log out'),
                              AppText.body('You are logged in as\n${AuthenticationService.email ?? 'unknown'}', Style.gray, TextAlign.start),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ]
            ),
          )
        ],
      ),
    );
  }
}
