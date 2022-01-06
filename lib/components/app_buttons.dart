import 'package:flutter/material.dart';
import 'package:taneo/style.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({Key? key, required this.callback, required this.text}) : super(key: key);
  final VoidCallback callback;
  final String text;

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Style.width * .7,
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
        onPressed: widget.callback,
        child: Text(
          widget.text,
          style: const TextStyle(
            letterSpacing: 1,
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

class SecondaryButton extends StatefulWidget {
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
  _SecondaryButtonState createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.grayText,
          style: const TextStyle(
            color: Style.gray,
          ),
        ),
        TextButton(
          onPressed: widget.callback,
          child: Text(
            widget.actionText,
            style: TextStyle(
              color: widget.color ?? Style.accent,
            ),
          ),
        ),
      ],
    );
  }
}

class LoginWith extends StatefulWidget {
  const LoginWith({Key? key, required this.callback, required this.imageName}) : super(key: key);
  final VoidCallback callback;
  final String imageName;

  @override
  _LoginWithState createState() => _LoginWithState();
}

class _LoginWithState extends State<LoginWith> {
  bool _clicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _clicked = true;
        });
      },
      child: CircleAvatar(
        backgroundColor: _clicked ? Style.accent : Colors.black.withOpacity(.2),
        radius: Style.width / 17 + 1,
        child: CircleAvatar(
          backgroundColor: Style.white,
          radius: Style.width / 17,
          child: Image.asset(
            'assets/login_logos/${widget.imageName}.png',
            width: Style.width / 13,
            height: Style.width / 13,
          ),
        ),
      ),
    );
  }
}

class BlackButton extends StatefulWidget {
  const BlackButton({Key? key, required this.callback, required this.text}) : super(key: key);
  final VoidCallback callback;
  final String text;

  @override
  _BlackButtonState createState() => _BlackButtonState();
}

class _BlackButtonState extends State<BlackButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Style.width * .65,
      height: Style.height / 17,
      child: TextButton(
        onPressed: widget.callback,
        child: Text(
          widget.text,
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
