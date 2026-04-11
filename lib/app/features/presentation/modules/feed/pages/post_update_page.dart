// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/post/post_update_dto.dart';
import 'package:pulse_post/app/features/presentation/modules/feed/widgets/forms/post_update_form_widget.dart';
import 'package:uikit/uikit.dart';

import 'package:pulse_post/app/features/domain/remocao/dtos/post/post_detail_dto.dart';
import 'package:pulse_post/app/features/presentation/controllers/posts/post_controller.dart';
import 'package:pulse_post/app/features/presentation/controllers/upload/local_upload_controller.dart';
import 'package:pulse_post/app/core/utils/constants/icons/icon_constant.dart';
import 'package:pulse_post/app/core/utils/constants/texts/text_constant.dart';

class PostUpdatePage extends StatefulWidget {
  final PostDetailDto data;
  const PostUpdatePage({super.key, required this.data});

  @override
  State<PostUpdatePage> createState() => _PostUpdatePageState();
}

class _PostUpdatePageState extends State<PostUpdatePage> {
  final postController = Injector.get<PostController>();

  final titleEC = TextEditingController();

  final descriptionEC = TextEditingController();

  final uploadController = Injector.get<LocalUploadController>();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleEC.text = widget.data.title;
    descriptionEC.text = widget.data.description;
    uploadController.setFileType(widget.data.postType);
  }

  @override
  void dispose() {
    titleEC.dispose();
    descriptionEC.dispose();
    uploadController.removeMedia();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContentDefault(
        child: Observer(
          builder: (_) {
            return SingleChildScrollView(
              child: Column(
                spacing: SizeToken.lg,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: SizeToken.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButtonLargeDark(
                            onTap: () => context.go('/my-profile'),
                            icon: IconConstant.arrowLeft,
                          ),
                          const SizedBox(width: SizeToken.sm),
                          TextHeadlineH2(text: TextConstant.editPost),
                        ],
                      ),
                      IconButtonLargeLight(
                        backgroundColor: ColorToken.danger,
                        isSquareBorderRadius: true,
                        onTap: () {
                          showCustomModalBottomSheet(
                            context: context,
                            builder: (context) => ModalSheet(
                              iconBack: IconConstant.arrowLeft,
                              description: TextConstant.deletePostMessage,
                              cancelText: TextConstant.cancel,
                              continueText: TextConstant.confirm,
                              continueOnTap: () async {
                                try {
                                  await postController.remove(widget.data.id);
                                } finally {
                                  context.go('/my-profile');
                                  await postController.listByFileType(
                                    widget.data.postType,
                                  );
                                }
                              },
                            ),
                          );
                        },
                        icon: IconConstant.remove,
                      ),
                    ],
                  ),
                  PostUpdateFormWidget(
                    formKey: formKey,
                    titleEC: titleEC,
                    descriptionEC: descriptionEC,
                    fileUrl: widget.data.file,
                  ),
                  Observer(
                    builder: (_) {
                      return SizedBox(
                        width: double.infinity,
                        child: ButtonSmallDark(
                          isLoading: postController.isLoading,
                          text: TextConstant.register,
                          onPressed: () async {
                            if (formKey.currentState?.validate() ??
                                false || uploadController.isSizeValid == true) {
                              final data = PostUpdateDto(
                                title: titleEC.text,
                                description: descriptionEC.text,
                              );
                              try {
                                await postController.update(
                                  widget.data.id,
                                  data,
                                  uploadController.file,
                                );
                              } finally {
                                if (postController.isLoading == false) {
                                  context.go('/my-profile');
                                  await postController.listByFileType(
                                    widget.data.postType,
                                  );
                                }
                              }
                            }
                          },
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
    );
  }
}
