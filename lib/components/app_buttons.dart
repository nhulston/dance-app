import 'package:flutter/material.dart';
import 'package:taneo/util/style.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.callback,
    required this.text,
    this.widthFactor,
  }) : super(key: key);
  final VoidCallback? callback;
  final String text;
  final double? widthFactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Style.width * .7 * (widthFactor ?? 1),
      height: Style.height / 17,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Style.accent, Style.accentGradient]),
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 4,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: callback,
        child: Text(
          text,
          style: const TextStyle(
            letterSpacing: 1,
            color: Style.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key? key,
    required this.callback,
    required this.grayText,
    required this.actionText,
    this.color,
  }) : super(key: key);
  final VoidCallback callback;
  final String grayText;
  final String actionText;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          grayText,
          style: const TextStyle(
            color: Style.gray,
          ),
        ),
        TextButton(
          onPressed: callback,
          child: Text(
            actionText,
            style: TextStyle(
              color: color ?? Style.accent,
            ),
          ),
        ),
      ],
    );
  }
}

class BlackButton extends StatelessWidget {
  const BlackButton({
    Key? key,
    required this.callback,
    required this.text,
  }) : super(key: key);

  final VoidCallback? callback;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Style.width * .65,
        height: Style.height / 17,
        child: TextButton(
          onPressed: callback,
          child: Text(
            text,
            style: const TextStyle(
              color: Style.white,
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Style.black),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
            ),
          ),
        )
    );
  }
}