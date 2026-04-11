// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_upload_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LocalUploadController on LocalUploadControllerBase, Store {
  late final _$fileAtom = Atom(
    name: 'LocalUploadControllerBase.file',
    context: context,
  );

  @override
  File? get file {
    _$fileAtom.reportRead();
    return super.file;
  }

  @override
  set file(File? value) {
    _$fileAtom.reportWrite(value, super.file, () {
      super.file = value;
    });
  }

  late final _$isSizeValidAtom = Atom(
    name: 'LocalUploadControllerBase.isSizeValid',
    context: context,
  );

  @override
  bool get isSizeValid {
    _$isSizeValidAtom.reportRead();
    return super.isSizeValid;
  }

  @override
  set isSizeValid(bool value) {
    _$isSizeValidAtom.reportWrite(value, super.isSizeValid, () {
      super.isSizeValid = value;
    });
  }

  late final _$isVideoAtom = Atom(
    name: 'LocalUploadControllerBase.isVideo',
    context: context,
  );

  @override
  bool get isVideo {
    _$isVideoAtom.reportRead();
    return super.isVideo;
  }

  @override
  set isVideo(bool value) {
    _$isVideoAtom.reportWrite(value, super.isVideo, () {
      super.isVideo = value;
    });
  }

  @override
  ObservableFuture<void> pickImageFromCamera() {
    final _$future = super.pickImageFromCamera();
    return ObservableFuture<void>(_$future, context: context);
  }

  late final _$uploadMediaAsyncAction = AsyncAction(
    'LocalUploadControllerBase.uploadMedia',
    context: context,
  );

  @override
  Future<void> uploadMedia() {
    return _$uploadMediaAsyncAction.run(() => super.uploadMedia());
  }

  late final _$uploadImageAsyncAction = AsyncAction(
    'LocalUploadControllerBase.uploadImage',
    context: context,
  );

  @override
  Future<void> uploadImage() {
    return _$uploadImageAsyncAction.run(() => super.uploadImage());
  }

  late final _$LocalUploadControllerBaseActionController = ActionController(
    name: 'LocalUploadControllerBase',
    context: context,
  );

  @override
  void setFileType(String type) {
    final _$actionInfo = _$LocalUploadControllerBaseActionController
        .startAction(name: 'LocalUploadControllerBase.setFileType');
    try {
      return super.setFileType(type);
    } finally {
      _$LocalUploadControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeMedia() {
    final _$actionInfo = _$LocalUploadControllerBaseActionController
        .startAction(name: 'LocalUploadControllerBase.removeMedia');
    try {
      return super.removeMedia();
    } finally {
      _$LocalUploadControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
file: ${file},
isSizeValid: ${isSizeValid},
isVideo: ${isVideo}
    ''';
  }
}
