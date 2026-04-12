import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:amago/app/features/presentation/controllers/posts/post_controller.dart';
import 'package:amago/app/features/presentation/modules/feed/widgets/details/post_detail_widget.dart';
import 'package:amago/app/core/utils/constants/images/image_constant.dart';
import 'package:amago/app/core/utils/constants/texts/text_constant.dart';
import 'package:uikit/uikit.dart';

class ListAllPostsWidget extends StatelessWidget {
  ListAllPostsWidget({super.key});

  final postController = Injector.get<PostController>();

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

        final posts = postController.postList;

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
          shrinkWrap: true,
          itemCount: postController.postList?.length ?? 0,
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
                PostDetailWidget(data: post),
              ],
            );
          },
        );
      },
    );
  }
}
