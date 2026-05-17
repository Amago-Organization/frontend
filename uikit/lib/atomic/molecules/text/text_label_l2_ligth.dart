// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class TextLabelL2Light extends StatelessWidget {
  final int? maxLines;
  final String text;
  final bool overflow;
  final Color? color;
  final TextAlign? textAlign;  
    final bool dropShadow;
  const TextLabelL2Light({
    super.key,
    this.maxLines,
    required this.text,
    this.overflow = false,
    this.color, this.textAlign, this.dropShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextDefault(
      text: text,
      textStyle: Style.l2(color: ColorToken.light),
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      dropShadow: dropShadow,
    );
  }
}
