import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taneo/util/style.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({
    Key? key,
    this.color
  }) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 15,
      top: MediaQuery.of(context).padding.top,
      child: IconButton(
        icon: Icon(CupertinoIcons.back, size: 32, color: color ?? Style.white),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}