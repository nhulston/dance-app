import 'package:flutter/material.dart';
import 'package:taneo/util/style.dart';

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({
    Key? key,
    required this.name,
    required this.description,
    required this.img,
    this.imageOnRight,
  }) : super(key: key);

  final String name;
  final String description;
  final String img;
  final bool? imageOnRight;

  @override
  Widget build(BuildContext context) {
    Widget image = SizedBox(
      width: Style.width / 2.7,
      child: Column(
        children: [
          Image.asset('assets/experience_icons/$img.png', width: Style.width / 5),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Style.accent,
                fontSize: Style.bodyFontSize + 1,
                height: 1.5,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1
            ),
          ),
        ],
      ),
    );

    Widget description = SizedBox(
      width: Style.width * .4,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Text(
          this.description,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Style.accent, fontSize: Style.bodyFontSize + 1, height: 1.5),
        ),
      ),
    );

    return SizedBox(
      width: Style.width * .9,
      height: Style.height * .19,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, Style.width / 15, Style.width / 15, Style.width / 15),
        child: Row(
          children: [
            imageOnRight == null ? image : description,
            const Spacer(),
            imageOnRight == null ? description : image,
          ],
        ),
      ),
    );
  }
}