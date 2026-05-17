// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class TextLabelL3SemiDark  extends StatelessWidget {
  final int? maxLines;
  final String text;
  final bool overflow;
  final Color? color;
    final bool dropShadow;

  const TextLabelL3SemiDark({
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
      textStyle: Style.l3(color: ColorToken.semiDark),
      overflow: overflow,
      maxLines: maxLines,
      dropShadow: dropShadow, 
    );
  }
}