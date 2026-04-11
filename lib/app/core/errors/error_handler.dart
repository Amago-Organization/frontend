import 'package:pulse_post/app/core/exceptions/rest_exception.dart';
import 'package:pulse_post/app/core/utils/constants/texts/text_constant.dart';

String getErrorMessage(Object failure) {
  if (failure is RestException) {
    if (failure.statusCode == 500) return TextConstant.serverError;

    return failure.message;
  }

  return TextConstant.unexpectedError;
}
