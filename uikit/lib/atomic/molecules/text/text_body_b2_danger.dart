// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class TextBodyB2Danger extends StatelessWidget {
  final int? maxLines;
  final String text;
  final bool overflow;
  final Color? color;
    final bool dropShadow;

  const TextBodyB2Danger({
    super.key,
    this.maxLines,
    required this.text,
    this.overflow = false,
    this.color,
    this.dropShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextDefault(
      text: text,
      textStyle: Style.b2(color: ColorToken.danger),
      overflow: overflow,
      maxLines: maxLines,
      dropShadow: dropShadow,
    );
  }
}
