// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/user/user_login_dto.dart';
import 'package:pulse_post/app/features/presentation/controllers/user/user_controller.dart';
import 'package:pulse_post/app/features/presentation/modules/auth/widgets/forms/user_login_form_widget.dart';
import 'package:pulse_post/app/core/utils/constants/texts/text_constant.dart';
import 'package:uikit/uikit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = Injector.get<UserController>();

  final emailEC = TextEditingController();

  final passwordEC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
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
            context.go('/feed');
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
                    TextHeadlineH2(text: TextConstant.loggin),
                    UserLoginFormWidget(
                      formKey: formKey,
                      emailEC: emailEC,
                      passwordEC: passwordEC,
                    ),
                    Observer(
                      builder: (_) {
                        return SizedBox(
                          width: double.infinity,
                          child: ButtonSmallDark(
                            isLoading: userController.isLoading,
                            text: TextConstant.loggin,
                            onPressed: () async {
                              if (formKey.currentState?.validate() ?? false) {
                                final data = UserLoginDto(
                                  email: emailEC.text,
                                  password: passwordEC.text,
                                );
                                try {
                                  await userController.login(data);
                                } finally {
                                  if (userController.isLoading == false) {
                                    await userController.load();
                                    if (userController.isTokenValid) {
                                      context.go('/feed');
                                    }
                                  }
                                }
                              }
                            },
                          ),
                        );
                      },
                    ),
                    LinkSeeMore(
                      text: TextConstant.dontAccount,
                      onTap: () => context.push('/register'),
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
