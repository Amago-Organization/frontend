import 'package:go_router/go_router.dart';
import 'package:amago/app/features/domain/entities/post_entity.dart';
import 'package:amago/app/features/domain/entities/user_entity.dart';
import 'package:amago/app/features/presentation/modules/auth/pages/login_page.dart';
import 'package:amago/app/features/presentation/modules/auth/pages/register_page.dart';
import 'package:amago/app/features/presentation/modules/auth/pages/splash_page.dart';
import 'package:amago/app/features/presentation/modules/auth/pages/update_page.dart';
import 'package:amago/app/features/presentation/modules/feed/pages/feed_page.dart';
import 'package:amago/app/features/presentation/modules/feed/pages/my_profile_page.dart';
import 'package:amago/app/features/presentation/modules/feed/pages/post_register_page.dart';
import 'package:amago/app/features/presentation/modules/feed/pages/post_update_page.dart';
import 'package:amago/app/core/utils/navigator/navigator_global.dart';

sealed class AppRoutes {
  static final GoRouter route = GoRouter(
    navigatorKey: NavigatorGlobal.navigatorKey,
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashPage()),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/register', builder: (context, state) => RegisterPage()),
      GoRoute(path: '/feed', builder: (context, state) => FeedPage()),

      
      GoRoute(
        path: '/my-profile',
        builder: (context, state) => MyProfilePage(),
      ),
      GoRoute(
        path: '/update',
        builder: (context, state) =>
            UpdatePage(data: state.extra as UserEntity),
      ),
      GoRoute(
        path: '/post/register',
        builder: (context, state) => PostRegisterPage(),
      ),
      GoRoute(
        path: '/post/update',
        builder: (context, state) =>
            PostUpdatePage(data: state.extra as PostEntity),
      ),
    ],
  );
}
