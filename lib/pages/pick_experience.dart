import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:taneo/components/app_buttons.dart';
import 'package:taneo/components/app_text.dart';
import 'package:taneo/components/back_arrow.dart';
import 'package:taneo/components/experience_card.dart';
import 'package:taneo/pages/paywall.dart';
import 'package:taneo/util/preferences.dart';
import 'package:taneo/util/style.dart';

class PickExperience extends StatefulWidget {
  const PickExperience({
    Key? key,
    this.callback,
  }) : super(key: key);

  final VoidCallback? callback;

  @override
  _PickExperienceState createState() => _PickExperienceState();
}

class _PickExperienceState extends State<PickExperience> {
  bool _firstTime = false;
  @override
  void initState() {
    log('Experience level: ${Preferences.getExperienceLevel()}');
    if (Preferences.getExperienceLevel() == -1) {
      _firstTime = true;
    }
    super.initState();
  }

  int _selected = -1;

  VoidCallback _onTap(int x) {
    return () {
      setState(() {
        _selected = x;
      });
    };
  }

  double _getElevation(int x) {
    return _selected == x ? 10 : 0;
  }

  Widget _experienceWrapper(Widget child, int x) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      elevation: _getElevation(x),
      child: Container(
        foregroundDecoration: _selected == x ? null : BoxDecoration(
          color: _selected == -1 || _selected == x ? Style.white : Colors.grey,
          backgroundBlendMode: BlendMode.saturation,
        ),
        child: GestureDetector(
          onTap: _onTap(x),
          behavior: HitTestBehavior.translucent,
          child: child,
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: Style.width,
              child: Column(
                children: [
                  if (!_firstTime) const SizedBox(height: 20),
                  SizedBox(height: Style.height / 20),
                  AppText.header('How experienced are you?', Style.accent),
                  const SizedBox(height: 10),
                  _experienceWrapper(
                      const ExperienceCard(
                          name: 'BEGINNER',
                          description: 'For dancers with less than one year of experience',
                          img: 'beginner'
                      ), 0),
                  const Spacer(),
                  Divider(thickness: 1, color: (_selected == -1) ? Colors.grey.shade300 : Colors.transparent),
                  const Spacer(),
                  _experienceWrapper(
                      const ExperienceCard(
                        name: 'INTERMEDIATE',
                        description: 'For dancers with one to three years of experience',
                        img: 'intermediate',
                        imageOnRight: true,
                      ), 1),
                  const Spacer(),
                  Divider(thickness: 1, color: (_selected == -1) ? Colors.grey.shade300 : Colors.transparent),
                  const Spacer(),
                  _experienceWrapper(
                      const ExperienceCard(
                          name: 'ADVANCED',
                          description: 'For dancers more than three years of experience',
                          img: 'advanced'
                      ), 2),
                  const Spacer(flex: 4),
                  PrimaryButton(callback: () {
                    if (_selected == -1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Please select a skill level'),
                          action: SnackBarAction(
                              label: 'Dismiss',
                              onPressed: () {}
                          ),
                        ),
                      );
                    } else {
                      Preferences.setExperienceLevel(_selected);
                      ScaffoldMessenger.of(context).clearSnackBars();
                      if (_firstTime) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const Paywall()
                          ),
                        );
                        setState(() {
                          _selected = -1;
                        });
                      } else {
                        Navigator.of(context).pop();
                        widget.callback!();
                      }
                    }
                  }, text: _firstTime ? 'NEXT STEP' : 'DONE'),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            if (!_firstTime) const BackArrow(color: Style.black),
          ],
        ),
      ),
    );
  }
}
