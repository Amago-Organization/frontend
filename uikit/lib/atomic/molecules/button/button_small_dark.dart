// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class ButtonSmallDark extends StatelessWidget {
  final String text;
  final bool isLoading;
  final void Function()? onPressed;
  const ButtonSmallDark({
    super.key,
    required this.text,
    this.isLoading = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonDefault(
      padding: const EdgeInsets.symmetric(horizontal: SizeToken.lg, vertical: SizeToken.xs),
      backgroundColor: ColorToken.dark,
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              height: SizeToken.md,
              width: SizeToken.md,
              child: CircularProgressIndicator(
                color: ColorToken.light,
              ),
            )
          : TextLabelL2Light(text: text),
    );
  }
}
