import 'package:flutter/material.dart';
import 'package:taneo/style.dart';

class AppText {
  static Text header(String s) {
    return Text(
      s,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static Text gray(String s) {
    return Text(
      s,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Style.gray,
      ),
    );
  }

  static Text error(String s) {
    return Text(
      s,
      style: const TextStyle(
        color: Style.error,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}