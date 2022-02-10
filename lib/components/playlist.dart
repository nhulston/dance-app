import 'package:flutter/material.dart';

import 'app_text.dart';

class Playlist extends StatelessWidget {
  const Playlist({
    Key? key,
    required this.name,
    required this.image,
    this.scale,
  }) : super(key: key);

  final String name;
  final String image;
  final double? scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: SizedBox(
        width: 100 * (scale ?? 1),
        height: 150 * (scale ?? 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO image,
            Image.asset('assets/experience_icons/advanced.png'),
            const SizedBox(height: 10),
            AppText.boldSubtext(name, scale ?? 1),
          ],
        ),
      ),
    );
  }
}