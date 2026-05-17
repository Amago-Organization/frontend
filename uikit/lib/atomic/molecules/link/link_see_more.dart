// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uikit/uikit.dart';
import 'package:flutter/material.dart';

class LinkSeeMore extends StatelessWidget {
  final String text;
    final bool dropShadow;

  final void Function() onTap;
  const LinkSeeMore({
    super.key,
    required this.text,
     this.dropShadow =false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: TextLabelL4Info(text: text, dropShadow: dropShadow),
    );
  }
}
