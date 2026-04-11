import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:pulse_post/app/features/presentation/controllers/upload/local_upload_controller.dart';
import 'package:pulse_post/app/core/utils/constants/icons/icon_constant.dart';
import 'package:pulse_post/app/core/utils/constants/texts/text_constant.dart';
import 'package:uikit/uikit.dart';
import 'package:validatorless/validatorless.dart';

class UserUpdateFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameEC;
  final TextEditingController bioEC;
  final String? fileUrl;
  UserUpdateFormWidget({
    super.key,
    required this.formKey,
    required this.nameEC,
    required this.bioEC,
    this.fileUrl,
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
                          cancelcontinueOnTap: (){
                              uploadController.pickImageFromCamera();
                              context.pop();
                          },
                          continueOnTap: (){
                            uploadController.uploadImage();
                            context.pop();
                          } 
                        ),
                      );
                    },
                    labelText: TextConstant.uploadMedia,
                    hintText: TextConstant.uploadMedia,
                    icon: IconConstant.upload,
                    isVideo: uploadController.isVideo,
                    fileUrl: fileUrl,
                  ),
                  uploadController.isSizeValid
                      ? SizedBox.shrink()
                      : TextBodyB2Danger(text: TextConstant.maxSizeFile),
                ],
              );
            },
          ),
          InputForm(
            hintText: TextConstant.name.toLowerCase(),
            controller: nameEC,
            textInputAction: TextInputAction.next,
            labelText: TextConstant.name,
            validator: Validatorless.required(TextConstant.fieldError),
          ),
          InputForm(
            hintText: TextConstant.bio.toLowerCase(),
            controller: bioEC,
            maxLines: 6,
            textInputAction: TextInputAction.next,
            labelText: TextConstant.bio,
          ),
        ],
      ),
    );
  }
}
