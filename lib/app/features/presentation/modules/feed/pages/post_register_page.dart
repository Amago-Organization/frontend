// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:amago/app/features/domain/params/posts/post_register_param.dart';
import 'package:amago/app/features/presentation/controllers/posts/post_controller.dart';
import 'package:amago/app/features/presentation/controllers/upload/local_upload_controller.dart';
import 'package:amago/app/features/presentation/modules/feed/widgets/forms/post_register_form_widget.dart';
import 'package:amago/app/core/utils/constants/icons/icon_constant.dart';
import 'package:amago/app/core/utils/constants/texts/text_constant.dart';
import 'package:uikit/uikit.dart';

class PostRegisterPage extends StatefulWidget {
  const PostRegisterPage({super.key});

  @override
  State<PostRegisterPage> createState() => _PostRegisterPageState();
}

class _PostRegisterPageState extends State<PostRegisterPage> {
  final postController = Injector.get<PostController>();

  final titleEC = TextEditingController();

  final descriptionEC = TextEditingController();

  final uploadController = Injector.get<LocalUploadController>();

  final formKey = GlobalKey<FormState>();

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
                            onTap: () => context.go('/feed'),
                            icon: IconConstant.arrowLeft,
                          ),
                          const SizedBox(width: SizeToken.sm),
                          TextHeadlineH2(text: TextConstant.newPost),
                        ],
                      ),
                    ],
                  ),
                  PostRegisterFormWidget(
                    formKey: formKey,
                    titleEC: titleEC,
                    descriptionEC: descriptionEC,
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
                              final data = PostRegisterParam(
                                title: titleEC.text,
                                description: descriptionEC.text,
                                file: uploadController.file,
                              );
                              try {
                                await postController.register(data);
                              } finally {
                                if (postController.isLoading == false) {
                                  context.go('/feed');
                                  await postController.list();
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
