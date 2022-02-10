import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:taneo/components/app_text.dart';

import '../util/style.dart';

class GenresBox extends StatelessWidget {
  const GenresBox({
    Key? key,
    required this.name,
    required this.color,
    required this.image,
  }) : super(key: key);

  final String name;
  final Color color;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log('[SearchTab build] Tapped ' + name);
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: AppText.header(name, Style.white, 0.9),
            ),
            if (image.isNotEmpty) Positioned(
              bottom: 15,
              right: -15,
              child: Transform.rotate(
                angle: 0.2,
                child: Image.asset('assets/search_icons/' + image + '.png', height: 90),
              ),
            )
          ],
        ),
      ),
    );
  }
}