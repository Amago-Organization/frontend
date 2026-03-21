// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:pulse_post/app/domain/enums/post_enum.dart';
import 'package:pulse_post/app/presentation/controllers/posts/post_controller.dart';
import 'package:pulse_post/app/presentation/controllers/user/user_controller.dart';
import 'package:pulse_post/app/presentation/modules/feed/controllers/button_navigator/button_navigator_menu_controller.dart';
import 'package:pulse_post/app/presentation/modules/feed/widgets/listPost/my_list_posts_widget.dart';
import 'package:pulse_post/app/utils/constants/icons/icon_constant.dart';
import 'package:pulse_post/app/utils/constants/images/image_constant.dart';
import 'package:pulse_post/app/utils/constants/texts/text_constant.dart';
import 'package:uikit/uikit.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final userController = Injector.get<UserController>();

  final postController = Injector.get<PostController>();

  final navigartorController = ButtonNavigatorMenuController();

  @override
  void initState() {
    super.initState();
    init();
  }

  late String type = PostEnum.IMAGE.type;

  Future<void> init() async {
    await userController.load();
    if (!userController.isTokenValid) {
      context.go('/login');
    } else {
      await postController.listByFileType(type);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => init(),
        child: LayoutBuilder(
          builder: (context, constraints) => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              ContentDefault(
                child: Observer(
                  builder: (_) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          const SizedBox(height: SizeToken.md),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButtonLargeDark(
                                    onTap: () async {
                                      context.go('/feed');
                                      await postController.list();
                                    },
                                    icon: IconConstant.arrowLeft,
                                  ),
                                  const SizedBox(width: SizeToken.sm),
                                  TextHeadlineH2(text: TextConstant.myProfile),
                                ],
                              ),
                              IconButtonLargeDark(
                                onTap: () => context.push(
                                  '/update',
                                  extra: userController.user,
                                ),
                                icon: IconConstant.edit,
                              ),
                            ],
                          ),
                          Observer(
                            builder: (_) {
                              if (userController.isLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (userController.isServerError) {
                                return BannerDefault(
                                  image: ImageConstant.serverError,
                                  text: TextConstant.serverError,
                                );
                              }
                              if (userController.user == null) {
                                return BannerDefault(
                                  image: ImageConstant.empty,
                                  text: TextConstant.postEmpty,
                                );
                              }
                              final user = userController.user;
                              return Padding(
                                padding: EdgeInsetsGeometry.only(
                                  top: SizeToken.lg,
                                ),
                                child: Column(
                                  spacing: SizeToken.xs,

                                  children: [
                                    ProfileMenuNavDetail(
                                      name: user?.name,
                                      image: user?.image,
                                      size: SizeToken.xl6,
                                    ),
                                    Column(
                                      children: [
                                        TextLabelL1Dark(
                                          text: user!.name.toString(),
                                        ),
                                        if (user.bio != null)
                                          TextBodyB1SemiDark(
                                            text: user.bio.toString(),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: SizeToken.lg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: SizeToken.sm),
                child: Observer(
                  builder: (context) {
                    final index = navigartorController.currentIndex;
                    return Row(
                      spacing: SizeToken.sm,
                      children: [
                        Expanded(
                          child: index == 0
                              ? ButtonSmallDark(
                                  text: TextConstant.images,
                                  onPressed: () async {
                                    navigartorController.onItemTapped(0);
                                    await postController.listByFileType(
                                      PostEnum.IMAGE.type,
                                    );
                                    type = PostEnum.IMAGE.type;
                                  },
                                )
                              : ButtonSmallLight(
                                  text: TextConstant.images,
                                  onPressed: () async {
                                    navigartorController.onItemTapped(0);
                                    await postController.listByFileType(
                                      PostEnum.IMAGE.type,
                                    );
                                    type = PostEnum.IMAGE.type;
                                  },
                                ),
                        ),
                        Expanded(
                          child: index == 1
                              ? ButtonSmallDark(
                                  text: TextConstant.videos,
                                  onPressed: () async {
                                    navigartorController.onItemTapped(1);
                                    await postController.listByFileType(
                                      PostEnum.VIDEO.type,
                                    );

                                    type = PostEnum.VIDEO.type;
                                  },
                                )
                              : ButtonSmallLight(
                                  text: TextConstant.videos,
                                  onPressed: () async {
                                    navigartorController.onItemTapped(1);
                                    await postController.listByFileType(
                                      PostEnum.VIDEO.type,
                                    );
                                    type = PostEnum.VIDEO.type;
                                  },
                                ),
                        ),
                        Expanded(
                          child: index == 2
                              ? ButtonSmallDark(
                                  text: TextConstant.texts,
                                  onPressed: () async {
                                    navigartorController.onItemTapped(2);
                                    await postController.listByFileType(
                                      PostEnum.TEXT.type,
                                    );
                                    type = PostEnum.TEXT.type;
                                  },
                                )
                              : ButtonSmallLight(
                                  text: TextConstant.texts,
                                  onPressed: () async {
                                    navigartorController.onItemTapped(2);
                                    await postController.listByFileType(
                                      PostEnum.TEXT.type,
                                    );
                                    type = PostEnum.TEXT.type;
                                  },
                                ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: SizeToken.md),
              Observer(
                builder: (_) {
                  return IndexedStack(
                    index: navigartorController.currentIndex,
                    children: [
                      MyListPostsWidget(type: PostEnum.IMAGE.type),
                      MyListPostsWidget(type: PostEnum.VIDEO.type),
                      MyListPostsWidget(type: PostEnum.TEXT.type),
                    ],
                  );
                },
              ),
              const SizedBox(height: SizeToken.lg),
            ],
          ),
        ),
      ),
    );
  }
}
