// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amago/app/core/utils/constants/icons/icon_constant.dart';
import 'package:amago/app/features/presentation/controllers/confirm_passoword/confirm_password_controller.dart';
import 'package:amago/app/features/presentation/controllers/visibility/visibility_controller.dart';
import 'package:flutter/material.dart';
import 'package:amago/app/core/utils/constants/texts/text_constant.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:uikit/uikit.dart';
import 'package:validatorless/validatorless.dart';

class UserRegisterFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameEC;
  final TextEditingController emailEC;
  final TextEditingController passwordEC;
  UserRegisterFormWidget({
    super.key,
    required this.formKey,
    required this.nameEC,
    required this.emailEC,
    required this.passwordEC,
  });

  final confirmPasswordController = ConfirmPasswordController();
  final confirmPasswordEC = TextEditingController();
  final visiblityControllerPassword = VisibilityController();
  final visiblityControllerConfirmPassword = VisibilityController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        spacing: SizeToken.sm,
        children: [
          InputForm(
            hintText: TextConstant.name,
            controller: nameEC,
            textInputAction: TextInputAction.next,
            labelText: TextConstant.name,
            inWallpaper: true,
            errorShadow: true,
            validator: Validatorless.required(TextConstant.fieldError),
          ),
          InputForm(
            hintText: TextConstant.email,
            controller: emailEC,
            textInputAction: TextInputAction.next,
            labelText: TextConstant.email,
            inWallpaper: true,
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
                textInputAction: TextInputAction.next,
                labelText: TextConstant.password,
                onChanged: confirmPasswordController.setPassword,
                errorShadow: true,
                inWallpaper: true,
                obscureText: visiblityControllerPassword.isVisible,
                sufixOnTap: visiblityControllerPassword.toggleVisibility,
                sufixIcon: visiblityControllerPassword.isVisible
                    ? IconConstant.visibilityOff
                    : IconConstant.visibility,
                validator: Validatorless.multiple([
                  Validatorless.min(
                    6,
                    TextConstant.passwordFiledMinCaractersError,
                  ),
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
            },
          ),
          Observer(
            builder: (_) {
              return InputForm(
                hintText: TextConstant.confirmPassword,
                controller: confirmPasswordEC,
                textInputAction: TextInputAction.done,
                labelText: TextConstant.confirmPassword,
                onChanged: confirmPasswordController.setConfirmPassword,
                errorShadow: true,
                inWallpaper: true,
                obscureText: visiblityControllerConfirmPassword.isVisible,
                sufixOnTap: visiblityControllerConfirmPassword.toggleVisibility,
                sufixIcon: visiblityControllerConfirmPassword.isVisible
                    ? IconConstant.visibilityOff
                    : IconConstant.visibility,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return TextConstant.fieldError;
                  }

                  if (value != passwordEC.text) {
                    return TextConstant.confirmYourPassword;
                  }

                  return null;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
