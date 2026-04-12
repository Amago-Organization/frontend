// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:amago/app/features/domain/entities/user_entity.dart';
import 'package:amago/app/features/domain/params/users/user_update_param.dart';

import 'package:amago/app/features/presentation/controllers/upload/local_upload_controller.dart';
import 'package:amago/app/features/presentation/controllers/user/user_controller.dart';
import 'package:amago/app/features/presentation/modules/auth/widgets/forms/user_update_form_widget.dart';
import 'package:amago/app/core/utils/constants/icons/icon_constant.dart';
import 'package:amago/app/core/utils/constants/texts/text_constant.dart';
import 'package:uikit/uikit.dart';

class UpdatePage extends StatefulWidget {
  final UserEntity data;
  const UpdatePage({super.key, required this.data});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final userController = Injector.get<UserController>();

  final nameEC = TextEditingController();

  final bioEC = TextEditingController();

  final uploadController = Injector.get<LocalUploadController>();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameEC.text = widget.data.name;
    bioEC.text = widget.data.bio ?? '';
  }

  @override
  void dispose() {
    nameEC.dispose();
    bioEC.dispose();
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
                          TextHeadlineH2(text: TextConstant.editUser),
                        ],
                      ),
                    ],
                  ),
                  UserUpdateFormWidget(
                    formKey: formKey,
                    nameEC: nameEC,
                    bioEC: bioEC,
                    fileUrl: widget.data.image,
                  ),
                  Observer(
                    builder: (_) {
                      return SizedBox(
                        width: double.infinity,
                        child: ButtonSmallDark(
                          isLoading: userController.isLoading,
                          text: TextConstant.save,
                          onPressed: () async {
                            if (formKey.currentState?.validate() ??
                                false || uploadController.isSizeValid == true) {
                              final data = UserUpdateParam(
                                name: nameEC.text,
                                bio: bioEC.text,
                                file: uploadController.file,
                              );
                              try {
                                await userController.update(data);
                              } finally {
                                if (userController.isLoading == false) {
                                  context.go('/my-profile');
                                  await userController.load();
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
