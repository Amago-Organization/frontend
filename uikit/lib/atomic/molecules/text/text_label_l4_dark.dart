// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class TextLabelL4Dark extends StatelessWidget {
  final int? maxLines;
  final String text;
  final bool overflow;
  final Color? color;
    final bool dropShadow;

  const TextLabelL4Dark({
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
      textStyle: Style.l4(color: ColorToken.dark),
      overflow: overflow,
      maxLines: maxLines,
      dropShadow: dropShadow,
    );
  }
}
