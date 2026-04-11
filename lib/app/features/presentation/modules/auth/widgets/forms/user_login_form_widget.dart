// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pulse_post/app/core/utils/constants/texts/text_constant.dart';
import 'package:uikit/uikit.dart';
import 'package:validatorless/validatorless.dart';

class UserLoginFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailEC;
  final TextEditingController passwordEC;
  const UserLoginFormWidget({
    super.key,
    required this.formKey,
    required this.emailEC,
    required this.passwordEC,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        spacing: SizeToken.sm,
        children: [
          InputForm(
            hintText: TextConstant.email.toLowerCase(),
            controller: emailEC,
            textInputAction: TextInputAction.next,
            labelText: TextConstant.email,
            validator: Validatorless.multiple([
              Validatorless.email(TextConstant.emailFieldError),
              Validatorless.required(TextConstant.fieldError),
            ]),
          ),
          InputForm(
            hintText: TextConstant.password.toLowerCase(),
            controller: passwordEC,
            textInputAction: TextInputAction.done,
            labelText: TextConstant.password,
            validator: Validatorless.multiple([
              Validatorless.min(6, TextConstant.passwordFiledMinCaractersError),
              Validatorless.required(TextConstant.fieldError),
            ]),
          ),
        ],
      ),
    );
  }
}
