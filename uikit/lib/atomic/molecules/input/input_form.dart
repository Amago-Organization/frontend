// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uikit/uikit.dart';

class InputForm extends StatelessWidget {
  final String labelText;
  final String hintText;
  final int maxLines;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType? keyBoardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final String? prefix;
  final bool enable;
  final String? sufixIcon;
  final void Function()? sufixOnTap;
  final bool errorShadow;
  final bool obscureText;
  final bool inWallpaper;
  final bool hasShadowInput;
  final void Function(String)? onChanged;

  const InputForm({
    super.key,
    required this.hintText,
    this.maxLines = 1,
    required this.controller,
    required this.textInputAction,
    this.keyBoardType,
    this.inputFormatters,
    this.validator,
    required this.labelText,
    this.prefix,
    this.enable = true,
    this.sufixIcon,
    this.sufixOnTap,
    this.errorShadow = false,
    this.obscureText = false, 
    this.inWallpaper = false,
    this.hasShadowInput = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputDefault(
          enable: enable,
          prefix: prefix,
          paddingLeftPrefix: SizeToken.sm,
          keyBoardType: keyBoardType,
          maxLines: maxLines,
          controller: controller,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          validator: validator,
          hintText: hintText,
          sufixIcon: sufixIcon,
          sufixOnTap: sufixOnTap,
          errorShadow: errorShadow,
          obscureText: obscureText,
          onChanged: onChanged,
          inWallpaper: inWallpaper,
          hasShadowInput: hasShadowInput,
        ),
      ],
    );
  }
}
