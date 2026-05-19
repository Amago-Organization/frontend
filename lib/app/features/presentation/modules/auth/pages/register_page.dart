// ignore_for_file: use_build_context_synchronously

import 'package:amago/app/core/utils/constants/images/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:amago/app/features/domain/params/users/user_register_param.dart';
import 'package:amago/app/features/presentation/controllers/user/user_controller.dart';
import 'package:amago/app/features/presentation/modules/auth/widgets/forms/user_register_form_widget.dart';
import 'package:amago/app/core/utils/constants/texts/text_constant.dart';
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
          builder: (context, constraints) => Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: constraints.maxHeight,
                  width: double.infinity,
                  child: Image.asset(
                    ImageConstant.wallpaperRegister,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(SizeToken.md),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: SizeToken.lg,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: SizeToken.sm1,
                        children: [
                          DecoratedBox(
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: ColorToken.dark,
                                  blurRadius: 60,
                                  spreadRadius: 0,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: SvgPicture.asset(
                              ImageConstant.logoHorizontalLight,
                              height: SizeToken.xl,
                            ),
                          ),
                          SizedBox(
                            width: 210,
                            child: TextLabelL2Light(
                              text: TextConstant.descriptionAmago,
                              textAlign: TextAlign.center,
                              dropShadow: true,
                            ),
                          ),
                        ],
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextHeadlineH1Light(
                            text: TextConstant.register,
                            dropShadow: true,
                          ),
                          SizedBox(height: SizeToken.md),
                          UserRegisterFormWidget(
                            formKey: formKey,
                            nameEC: nameEC,
                            emailEC: emailEC,
                            passwordEC: passwordEC,
                          ),
                          SizedBox(height: SizeToken.md),
                          Observer(
                            builder: (_) {
                              return SizedBox(
                                width: double.infinity,
                                child: ButtonSmallDark(
                                  isLoading: userController.isLoading,
                                  text: TextConstant.register,
                                  onPressed: () async {
                                    if (formKey.currentState?.validate() ??
                                        false) {
                                      final data = UserRegisterParam(
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
                          SizedBox(height: SizeToken.md),
                          LinkSeeMore(
                            text: TextConstant.hasAccount,
                            dropShadow: true,
                            onTap: () => context.push('/login'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
