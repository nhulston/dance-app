import 'package:flutter/material.dart';
import 'package:taneo/components/app_buttons.dart';
import 'package:taneo/components/app_text.dart';
import 'package:taneo/components/back_arrow.dart';
import 'package:taneo/components/plan_card.dart';
import 'package:taneo/pages/home.dart';
import 'package:taneo/util/style.dart';

class Paywall extends StatefulWidget {
  const Paywall({Key? key}) : super(key: key);

  @override
  _PaywallState createState() => _PaywallState();
}

class _PaywallState extends State<Paywall> {
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

  Widget _planWrapper(Widget child, int x) {
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
      body: Stack(
        children: [
          const BackArrow(color: Style.black),
          Positioned(
            left: 70,
            top: MediaQuery.of(context).padding.top + 11,
            child: AppText.header('Our plans'),
          ),
          Positioned(
            left: 70,
            top: MediaQuery.of(context).padding.top + 50,
            child: AppText.body('You can cancel or\nadd a plan at any time', Style.gray, TextAlign.left),
          ),
          Positioned(
            left: Style.width * .05,
            right: Style.width * .05,
            top: MediaQuery.of(context).padding.top + 120,
            height: Style.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _planWrapper(
                  const PlanCard(
                    name: 'Free',
                    img: 'free',
                    benefits: [
                      '100+ free exercises',
                      '20+ professionally made playlists',
                      'Create up to 3 playlists',
                    ],
                    cost: 'Free',
                  ),
                0),
                Divider(thickness: 1, color: (_selected == -1) ? Colors.grey.shade300 : Colors.transparent),
                _planWrapper(
                  const PlanCard(
                    name: 'Premium',
                    img: 'premium',
                    benefits: [
                      '1000+ exercises',
                      '100+ professionally made playlists',
                      'Create unlimited playlists',
                    ],
                    cost: '\$9.99 / month',
                  ),
                1),
                const SizedBox(height: 20),
                PrimaryButton(callback: () {
                  if (_selected == -1) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Please select a plan'),
                        action: SnackBarAction(
                            label: 'Dismiss',
                            onPressed: () {}
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const Home()
                        ),
                        ModalRoute.withName('/')
                    );
                    setState(() {
                      _selected = -1;
                    });
                  }
                }, text: 'NEXT STEP'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
