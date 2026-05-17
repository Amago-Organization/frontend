// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class TextBodyB1SemiDark extends StatelessWidget {
  final int? maxLines;
  final String text;
  final bool overflow;
  final Color? color;
  final bool isLimited;
    final bool dropShadow;

  TextBodyB1SemiDark({
    super.key,
    this.maxLines,
    required this.text,
    this.overflow = false,
    this.color,
    this.dropShadow = false,
    this.isLimited = false,
  });

  late final displayChars =
      text.length > 80 ? '${text.substring(0, 80)}... mais' : text;

  @override
  Widget build(BuildContext context) {
    return TextDefault(
      text: isLimited ? displayChars : text,
      textStyle: Style.b1(color: ColorToken.semiDark),
      overflow: overflow,
      maxLines: maxLines,
      dropShadow: dropShadow,
    );
  }
}
