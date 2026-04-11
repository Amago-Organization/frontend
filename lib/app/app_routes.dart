import 'package:go_router/go_router.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/post/post_detail_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/user/user_detail_dto.dart';
import 'package:pulse_post/app/features/presentation/modules/auth/pages/login_page.dart';
import 'package:pulse_post/app/features/presentation/modules/auth/pages/register_page.dart';
import 'package:pulse_post/app/features/presentation/modules/auth/pages/splash_page.dart';
import 'package:pulse_post/app/features/presentation/modules/auth/pages/update_page.dart';
import 'package:pulse_post/app/features/presentation/modules/feed/pages/feed_page.dart';
import 'package:pulse_post/app/features/presentation/modules/feed/pages/my_profile_page.dart';
import 'package:pulse_post/app/features/presentation/modules/feed/pages/post_register_page.dart';
import 'package:pulse_post/app/features/presentation/modules/feed/pages/post_update_page.dart';
import 'package:pulse_post/app/core/utils/navigator/navigator_global.dart';

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
            UpdatePage(data: state.extra as UserDetailDto),
      ),
      GoRoute(
        path: '/post/register',
        builder: (context, state) => PostRegisterPage(),
      ),
      GoRoute(
        path: '/post/update',
        builder: (context, state) =>
            PostUpdatePage(data: state.extra as PostDetailDto),
      ),
    ],
  );
}
