// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pulse_post/app/core/utils/constants/texts/text_constant.dart';

import 'package:uikit/uikit.dart';

import '../../utils/constants/icons/icon_constant.dart';
import 'result_message_service.dart';

class ResultMessageServiceImpl implements ResultMessageService {
  final GlobalKey<NavigatorState> navigatorKey;
  ResultMessageServiceImpl({
    required this.navigatorKey,
  });

  @override
  void showMessageError(String message) {
    if (navigatorKey.currentContext != null) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBarListview(
          title: TextConstant.errorTitle,
          subtitle: message,
          iconLeading: IconConstant.error,
          iconTrailing: IconConstant.close,
          context: navigatorKey.currentContext!,
          isSuccess: false,
        ),
      );
    }
  }

  @override
  void showMessageSuccess(String title, String message) {
    if (navigatorKey.currentContext != null) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBarListview(
          title: title,
          subtitle: message,
          iconLeading: IconConstant.success,
          iconTrailing: IconConstant.close,
          context: navigatorKey.currentContext!,
        ),
      );
    }
  }
}
