import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:pulse_post/app/features/domain/enums/post_enum.dart';
import 'package:image_picker/image_picker.dart';
part 'local_upload_controller.g.dart';

class LocalUploadController = LocalUploadControllerBase
    with _$LocalUploadController;

abstract class LocalUploadControllerBase with Store {
  @observable
  File? file;

  @observable
  bool isSizeValid = true;

  @observable
  bool isVideo = false;

  File? get selectedFile => file != null ? File(file!.path) : null;

  @action
  void setFileType(String type) {
    if (type == PostEnum.VIDEO.type) {
      isVideo = true;
    } else {
      isVideo = false;
    }
  }

  @action
  Future<void> uploadMedia() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'mp4'],
      allowMultiple: false,
    );

    if (pickedFile == null) return;

    final result = pickedFile.files.first;
    final maxSizeFile = 10 * 1024 * 1024;
    if (result.size > maxSizeFile) {
      isSizeValid = false;
      return;
    } else {
      isSizeValid = true;
      final newFile = pickedFile.files.first.path.toString();
      final ext = newFile.split('.').last.toLowerCase();
      isVideo = ext == 'mp4' ? true : false;
      file = File(newFile);
    }
  }

  @action
  Future<void> uploadImage() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
      allowMultiple: false,
    );

    if (pickedFile == null) return;

    final result = pickedFile.files.first;
    final maxSizeFile = 10 * 1024 * 1024;
    if (result.size > maxSizeFile) {
      isSizeValid = false;
      return;
    } else {
      isSizeValid = true;
      final newFile = pickedFile.files.first.path.toString();
      file = File(newFile);
    }
  }

  @observable
  Future<void> pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image == null) return;
    final File imageFile = File(image.path);

    final int fileSizeBytes = await imageFile.length();

    const int maxSizeFile = 10 * 1024 * 1024;

    if (fileSizeBytes > maxSizeFile) {
      isSizeValid = false;
      return;
    }

    isSizeValid = true;
    isVideo = false;
    file = imageFile;
  }

  @action
  void removeMedia() {
    file = null;
    isSizeValid = true;
    isVideo = false;
  }
}
