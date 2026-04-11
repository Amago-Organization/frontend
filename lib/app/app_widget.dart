import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:pulse_post/app/app_bindings.dart';
import 'package:pulse_post/app/app_routes.dart';
import 'package:pulse_post/app/features/presentation/modules/auth/auth_module.dart';
import 'package:uikit/uikit.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterGetIt(
      bindings: AppBindings(),
      modules: [AuthModule()],
      builder: (context, routes, flutterGetItNavObserver) {
        return MaterialApp.router(
          title: 'PulsePost',
          theme: theme,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRoutes.route,
        );
      },
    );
  }
}
