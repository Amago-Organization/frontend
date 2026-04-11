// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/user/user_register_dto.dart';
import 'package:pulse_post/app/features/presentation/controllers/user/user_controller.dart';
import 'package:pulse_post/app/features/presentation/modules/auth/widgets/forms/user_register_form_widget.dart';
import 'package:pulse_post/app/core/utils/constants/texts/text_constant.dart';
import 'package:uikit/uikit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userController = Injector.get<UserController>();

  final nameEC = TextEditingController();

  final emailEC = TextEditingController();

  final passwordEC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await userController.load();
          if (userController.isTokenValid) {
            context.push('/feed');
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(SizeToken.md),
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: constraints.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: SizeToken.lg,
                  children: [
                    TextHeadlineH2(text: TextConstant.register),
                    UserRegisterFormWidget(
                      formKey: formKey,
                      nameEC: nameEC,
                      emailEC: emailEC,
                      passwordEC: passwordEC,
                    ),
                    Observer(
                      builder: (_) {
                        return SizedBox(
                          width: double.infinity,
                          child: ButtonSmallDark(
                            isLoading: userController.isLoading,
                            text: TextConstant.register,
                            onPressed: () async {
                              if (formKey.currentState?.validate() ?? false) {
                                final data = UserRegisterDto(
                                  name: nameEC.text,
                                  email: emailEC.text,
                                  password: passwordEC.text,
                                );
                                try {
                                  await userController.register(data);
                                } finally {
                                  if (userController.isLoading == false) {
                                    context.go('/login');
                                  }
                                }
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
