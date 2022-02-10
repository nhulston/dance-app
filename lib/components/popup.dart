import 'package:flutter/material.dart';
import 'package:taneo/util/style.dart';

class Popup extends StatelessWidget {
  const Popup({
    Key? key,
    required this.title,
    required this.content,
    required this.okCallback,
  }) : super(key: key);

  final String title;
  final Widget content;
  final VoidCallback okCallback;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      title: Text(title),
      content: content,
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
            onPressed: okCallback,
            child: const Text('Confirm')
        ),
      ],
    );
  }
}