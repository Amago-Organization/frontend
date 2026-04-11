// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pulse_post/app/features/presentation/modules/feed/widgets/details/post_detail_widget.dart';
import 'package:uikit/uikit.dart';

import 'package:pulse_post/app/features/presentation/controllers/posts/post_controller.dart';
import 'package:pulse_post/app/core/utils/constants/images/image_constant.dart';
import 'package:pulse_post/app/core/utils/constants/texts/text_constant.dart';

class MyListPostsWidget extends StatefulWidget {
  final String type;
  const MyListPostsWidget({super.key, required this.type});

  @override
  State<MyListPostsWidget> createState() => _MyListPostsWidgetState();
}

class _MyListPostsWidgetState extends State<MyListPostsWidget> {
  final postController = Injector.get<PostController>();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async => await postController.listByFileType(widget.type);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (postController.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (postController.isServerError) {
          return BannerDefault(
            image: ImageConstant.serverError,
            text: TextConstant.serverError,
          );
        }

        final posts = postController.postListByFileType;

        if (posts == null || posts.isEmpty) {
          return BannerDefault(
            image: ImageConstant.empty,
            text: TextConstant.postEmpty,
          );
        }
        return ListView.separated(
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.only(top: SizeToken.xs, bottom: SizeToken.sm),
            child: DividerDefault(color: ColorToken.neutral, thickness: 1),
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: postController.postListByFileType?.length ?? 0,
          itemBuilder: (context, index) {
            final post = posts[index];
            return Column(
              children: [
                if (index == 0)
                  const Padding(
                    padding: EdgeInsets.only(bottom: SizeToken.sm),
                    child: DividerDefault(
                      color: ColorToken.neutral,
                      thickness: 1,
                    ),
                  ),
                PostDetailWidget(data: post, isMyPost: true),
              ],
            );
          },
        );
      },
    );
  }
}
