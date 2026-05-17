// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class ButtonDefault extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  final Color backgroundColor;
  final EdgeInsets padding;
  final bool isBorderRadio;
  const ButtonDefault({
    super.key,
    this.onPressed,
    required this.child,
    required this.backgroundColor,
    required this.padding,
    this.isBorderRadio = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: isBorderRadio
                ? BorderRadius.circular(SizeToken.md)
                : BorderRadius.circular(0),
          ),
        ),
        elevation: const WidgetStatePropertyAll<double>(0),
        padding: WidgetStatePropertyAll(padding),
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
      ),
      child: child,
    );
  }
}
