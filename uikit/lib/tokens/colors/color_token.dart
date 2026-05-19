import 'package:flutter/material.dart';

final class ColorToken {
  static const Color danger = Color(0xffFE0000);
  static const Color dark = Color(0xff0f0f0f);
  static const Color semiDark = Color(0xff9e968f);
  static const Color neutral = Color(0xfffaf8f5);
  static const Color light = Color(0xffffffff);
  static const Color success = Color(0xff38b257);

  static String colorToHex(Color color) {
    return '#${color.toARGB32().toRadixString(16).padLeft(6, '0').toUpperCase().substring(2)}';
  }
}
