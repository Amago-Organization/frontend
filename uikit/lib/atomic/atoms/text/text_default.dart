// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class TextDefault extends StatelessWidget {
  final String text;
  final bool overflow;
  final TextStyle textStyle;
  final int? maxLines;
  final TextAlign? textAlign;
  final bool dropShadow;
  const TextDefault({
    super.key,
    required this.text,
    this.overflow = false,
    required this.textStyle,
    this.maxLines,
    this.textAlign,
    this.dropShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      overflow: overflow ? TextOverflow.ellipsis : null,
      style: dropShadow
          ? textStyle.copyWith(
              shadows: const [
                Shadow(
                  offset: Offset(0, 0),
                  blurRadius: 50,
                  color: ColorToken.dark,
                ),
              ],
            )
          : textStyle,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
