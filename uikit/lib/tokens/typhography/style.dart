import 'package:uikit/tokens/typhography/font.dart';
import 'package:flutter/material.dart';

final class Style {
  static TextStyle h1({Color? color}) => TextStyle(
      fontSize: Font.lg,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
      color: color);

  static TextStyle h2({Color? color}) => TextStyle(
      fontSize: Font.md,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
      color: color);

  static TextStyle b1({Color? color}) => TextStyle(
      fontSize: Font.xs,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
      color: color);

  static TextStyle b2({Color? color}) => TextStyle(
      fontSize: Font.xxs,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
      color: color);

  static TextStyle l1({Color? color}) => TextStyle(
      fontSize: Font.sm,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
      color: color);

  static TextStyle l2({Color? color}) => TextStyle(
      fontSize: Font.xs,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
      color: color);

  static TextStyle l3({Color? color}) => TextStyle(
      fontSize: Font.sm,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
      color: color);

  static TextStyle l4({Color? color}) => TextStyle(
      fontSize: Font.xs,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
      color: color);

  static TextStyle l5({Color? color}) => TextStyle(
      fontSize: Font.xxs,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
      color: color);

  static TextStyle l6({Color? color}) => TextStyle(
      fontSize: Font.xxs,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
      color: color);
}
