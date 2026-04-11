import 'package:flutter/material.dart';

sealed class NavigatorGlobal {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}
