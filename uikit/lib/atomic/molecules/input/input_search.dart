// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class InputSearch extends StatelessWidget {
  final void Function(String)? onChanged;
  final void Function()? sufixOnTap;
  final String hintText;
  final String prefixIcon;
  final String? sufixIcon;
  final bool hasShadowInput;
  const InputSearch({
    super.key,
    this.onChanged,
    required this.hintText,
    required this.prefixIcon,
    this.sufixIcon,
    this.sufixOnTap,
    this.hasShadowInput = false,
  });

  @override
  Widget build(BuildContext context) {
    return InputDefault(
      
      hintText: hintText,
      prefixIcon: prefixIcon,
      sufixIcon: sufixIcon,
      onChanged: onChanged,
      sufixOnTap: sufixOnTap,
      hasShadowInput: hasShadowInput,
    );
  }
}
