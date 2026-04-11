// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:pulse_post/app/features/presentation/controllers/upload/local_upload_controller.dart';
import 'package:pulse_post/app/core/utils/constants/icons/icon_constant.dart';
import 'package:pulse_post/app/core/utils/constants/texts/text_constant.dart';
import 'package:uikit/uikit.dart';
import 'package:validatorless/validatorless.dart';

class PostRegisterFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleEC;
  final TextEditingController descriptionEC;
  PostRegisterFormWidget({
    super.key,
    required this.formKey,
    required this.titleEC,
    required this.descriptionEC,
  });

  final uploadController = Injector.get<LocalUploadController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        spacing: SizeToken.sm,
        children: [
          Observer(
            builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: SizeToken.xxs,
                children: [
                  InputUploadMedia(
                    file: uploadController.selectedFile,
                    onTap: () {
                      showCustomModalBottomSheet(
                        context: context,
                        builder: (context) => ModalSheet(
                          cancelText: TextConstant.camera,
                          continueText: TextConstant.files,
                          cancelcontinueOnTap: () {
                            uploadController.pickImageFromCamera();
                            context.pop();
                          },
                          continueOnTap: () {
                            uploadController.uploadMedia();
                            context.pop();
                          },
                        ),
                      );
                    },
                    labelText: TextConstant.uploadMedia,
                    hintText: TextConstant.uploadMedia,
                    icon: IconConstant.upload,
                    isVideo: uploadController.isVideo,
                  ),
                  uploadController.isSizeValid
                      ? SizedBox.shrink()
                      : TextBodyB2Danger(text: TextConstant.maxSizeFile),
                ],
              );
            },
          ),
          InputForm(
            hintText: TextConstant.title.toLowerCase(),
            controller: titleEC,
            textInputAction: TextInputAction.next,
            labelText: TextConstant.title,
            validator: Validatorless.required(TextConstant.fieldError),
          ),
          InputForm(
            hintText: TextConstant.description.toLowerCase(),
            controller: descriptionEC,
            maxLines: 6,
            textInputAction: TextInputAction.next,
            labelText: TextConstant.description,
            validator: Validatorless.required(TextConstant.fieldError),
          ),
        ],
      ),
    );
  }
}
