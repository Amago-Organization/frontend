// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amago/app/core/utils/constants/icons/icon_constant.dart';
import 'package:amago/app/features/presentation/controllers/visibility/visibility_controller.dart';
import 'package:flutter/material.dart';
import 'package:amago/app/core/utils/constants/texts/text_constant.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:uikit/uikit.dart';
import 'package:validatorless/validatorless.dart';

class UserLoginFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailEC;
  final TextEditingController passwordEC;

  UserLoginFormWidget({
    super.key,
    required this.formKey,
    required this.emailEC,
    required this.passwordEC,
  });

  final visiblityController = VisibilityController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        spacing: SizeToken.sm,
        children: [
          InputForm(
            hintText: TextConstant.email,
            controller: emailEC,
            textInputAction: TextInputAction.next,
            labelText: TextConstant.email,
            errorShadow: true,
            validator: Validatorless.multiple([
              Validatorless.email(TextConstant.emailFieldError),
              Validatorless.required(TextConstant.fieldError),
            ]),
          ),
          Observer(
            builder: (_) {
              return InputForm(
                hintText: TextConstant.password,
                controller: passwordEC,
                textInputAction: TextInputAction.done,
                labelText: TextConstant.password,
                errorShadow: true,
                obscureText: visiblityController.isVisible,
                sufixOnTap: visiblityController.toggleVisibility,
                sufixIcon: visiblityController.isVisible
                    ? IconConstant.visibilityOff
                    : IconConstant.visibility,
                validator: Validatorless.multiple([
                  Validatorless.min(6, TextConstant.passwordFiledMinCaractersError),
                  Validatorless.max(
                    10,
                    TextConstant.passwordFiledMaxCaractersError,
                  ),
                  Validatorless.regex(
                    RegExp(RegexToken.hasLowercase),
                    TextConstant.passwordFieldLowercaseError,
                  ),
                  Validatorless.regex(
                    RegExp(RegexToken.hasUppercase),
                    TextConstant.passwordFieldUppercaseError,
                  ),
                  Validatorless.regex(
                    RegExp(RegexToken.hasSpecialCharacter),
                    TextConstant.passwordFieldSpecialCharacterError,
                  ),
                  Validatorless.regex(
                    RegExp(RegexToken.hasNumber),
                    TextConstant.passwordFieldNumberError,
                  ),
                  Validatorless.required(TextConstant.fieldError),
                ]),
              );
            }
          ),
        ],
      ),
    );
  }
}
