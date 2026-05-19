// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class DividerDefault extends StatelessWidget {
  final Color? color;
  final double? thickness;
  const DividerDefault({
    super.key,
    this.color,
    this.thickness,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? ColorToken.dark.withValues(alpha: 0.25),
      thickness: thickness ?? 0.1,
    );
  }
}
