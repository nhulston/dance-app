import 'package:flutter/material.dart';
import 'package:taneo/util/style.dart';

class AppText {
  static Text header(String s, [Color color = Style.black, double sizeFactor = 1]) {
    return Text(
      s,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24 * sizeFactor,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  static TextStyle bodyStyle([Color color = Style.gray]) {
    return TextStyle(color: color, fontSize: Style.bodyFontSize, height: 1.5);
  }

  static Text body(String s, [Color color = Style.gray, TextAlign textAlign = TextAlign.center]) {
    return Text(
      s,
      textAlign: textAlign,
      style: bodyStyle(color),
    );
  }

  static Text boldSubtext(String s, [double scale = 1]) {
    return Text(
      s,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 13 * scale,
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