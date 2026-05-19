// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:amago/app/features/presentation/controllers/posts/post_controller.dart';
import 'package:amago/app/features/presentation/controllers/user/user_controller.dart';
import 'package:amago/app/features/presentation/modules/feed/widgets/listPost/list_all_posts_widget.dart';
import 'package:amago/app/core/utils/constants/icons/icon_constant.dart';
import 'package:amago/app/core/utils/constants/images/image_constant.dart';
import 'package:amago/app/core/utils/constants/texts/text_constant.dart';
import 'package:uikit/uikit.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final userController = Injector.get<UserController>();
  final postController = Injector.get<PostController>();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await userController.load();
    if (!userController.isTokenValid) {
      context.go('/login');
    } else {
      await postController.list();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: ColorToken.light,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            SizeToken.xxl - 3.5,
            SizeToken.sm,
            SizeToken.xxl,
            0,
          ),
          child: AppBar(
            title: Image.asset(
              ImageConstant.logoHorizontal,
              height: SizeToken.xxl,
            ),

            actions: [
              IconButtonLargeDark(
                onTap: () => context.push('/post/register'),
                icon: IconConstant.add,
              ),
              const SizedBox(width: SizeToken.xxs),
              Padding(
                padding: const EdgeInsets.all(3.5),
                child: Observer(
                  builder: (_) => PopUpMenuShare(
                    menuIcon: ProfileMenuNavDetail(
                      name: userController.user?.name,
                      image: userController.user?.image,
                    ),
                    firstLabel: TextConstant.myProfile,
                    firstIcon: IconConstant.user,
                    firtOnTap: () => context.push('/my-profile'),
                    secoundLabel: TextConstant.logout,
                    secoundIcon: IconConstant.logout,
                    secoundOnTap: () async {
                      await userController.logout();
                      if (!userController.isTokenValid) {
                        context.go('/login');
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.25,
              child: Image.asset(ImageConstant.wallpaperApp, fit: BoxFit.cover),
            ),
          ),
          RefreshIndicator(
            onRefresh: () async => init(),
            child: LayoutBuilder(
              builder: (context, constraints) => Padding(
                padding: EdgeInsets.only(
                  top: kToolbarHeight  + SizeToken.xxl,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: SizeToken.xxl, bottom: SizeToken.lg, left: SizeToken.xxl, right: SizeToken.xxl),
                      child: InputSearch(
                        hintText: TextConstant.search,
                        prefixIcon: IconConstant.search,
                        hasShadowInput: true,
                      ),
                    ),
                    DividerDefault(),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: SizeToken.sm1,
                        vertical: SizeToken.lg
                      ),
                      child: ListAllPostsWidget(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
