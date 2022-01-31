import 'package:flutter/material.dart';
import 'package:taneo/components/app_buttons.dart';
import 'package:taneo/components/app_text.dart';
import 'package:taneo/util/style.dart';

class PlanCard extends StatefulWidget {
  const PlanCard({
    Key? key,
    required this.name,
    required this.img,
    required this.benefits,
    required this.cost,
  }) : super(key: key);

  final String name;
  final String img;
  final List<String> benefits;
  final String cost;

  @override
  _PlanCardState createState() => _PlanCardState();
}

class _PlanCardState extends State<PlanCard> {
  Text _getBullet(String s) {
    return Text(
      '•' + s,
      textAlign: TextAlign.left,
      style: const TextStyle(fontSize: Style.bodyFontSize + 1, height: 1.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget image = SizedBox(
      width: Style.width / 3,
      child: Column(
        children: [
          Image.asset('assets/paywall_icons/${widget.img}.png', width: Style.width / 5),
          const SizedBox(height: 10),
          AppText.header(widget.name, Style.black, .9)
        ],
      ),
    );

    Widget description = SizedBox(
      width: Style.width * .5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (String s in widget.benefits) _getBullet(s),
          ]
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(0, Style.width / 15, 0, Style.width / 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              image,
              const Spacer(),
              description,
            ],
          ),
          const SizedBox(height: 20),
          PrimaryButton(callback: null, text: widget.cost, widthFactor: .85),
        ],
      )
    );
  }
}
