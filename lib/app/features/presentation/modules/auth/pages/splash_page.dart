// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:go_router/go_router.dart';
import 'package:pulse_post/app/core/services/local/local_storage_service.dart';
import 'package:pulse_post/app/features/presentation/controllers/user/user_controller.dart';
import 'package:pulse_post/app/core/utils/constants/images/image_constant.dart';
import 'package:pulse_post/app/core/utils/constants/texts/text_constant.dart';
import 'package:uikit/uikit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final userController = Injector.get<UserController>();
  final localStorageService = Injector.get<LocalStorageService>();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await userController.load();

    if (userController.isTokenValid) {
      context.go('/feed');
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => await init(),
        child: LayoutBuilder(
          builder: (context, constraints) => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Builder(
                  builder: (context) {
                    if (userController.isServerError) {
                      return BannerDefault(
                        image: ImageConstant.serverError,
                        text: TextConstant.serverError,
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
