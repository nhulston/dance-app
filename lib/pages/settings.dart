import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:taneo/components/app_text.dart';
import 'package:taneo/pages/first_login.dart';
import 'package:taneo/util/authentication_service.dart';
import 'package:taneo/util/style.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
                          onTap: () {},
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
                          onTap: () {},
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
                        AppText.boldSubtext('Change Skill Level'),
                        AppText.body('Beginner'),
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
                              builder: (context) => AlertDialog(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(16)),
                                ),
                                title: const Text('Confirm log out'),
                                content: const Text('Are you sure you want to log out?'),
                                actions: [
                                  TextButton(
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(color: Style.gray, fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                                    ),
                                    onPressed: () {
                                      context.read<AuthenticationService>().signOut();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const FirstLogin()
                                        ),
                                        ModalRoute.withName('/Home')
                                      );
                                    },
                                    child: const Text('Confirm')
                                  ),
                                ],
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
