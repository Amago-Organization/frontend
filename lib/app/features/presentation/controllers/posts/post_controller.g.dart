// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PostController on PostControllerBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??= Computed<bool>(
    () => super.isLoading,
    name: 'PostControllerBase.isLoading',
  )).value;
  Computed<bool>? _$isServerErrorComputed;

  @override
  bool get isServerError => (_$isServerErrorComputed ??= Computed<bool>(
    () => super.isServerError,
    name: 'PostControllerBase.isServerError',
  )).value;
  Computed<PostDetailDto?>? _$postComputed;

  @override
  PostDetailDto? get post => (_$postComputed ??= Computed<PostDetailDto?>(
    () => super.post,
    name: 'PostControllerBase.post',
  )).value;
  Computed<List<PostDetailDto>?>? _$postListComputed;

  @override
  List<PostDetailDto>? get postList =>
      (_$postListComputed ??= Computed<List<PostDetailDto>?>(
        () => super.postList,
        name: 'PostControllerBase.postList',
      )).value;
  Computed<List<PostDetailDto>?>? _$postListByFileTypeComputed;

  @override
  List<PostDetailDto>? get postListByFileType =>
      (_$postListByFileTypeComputed ??= Computed<List<PostDetailDto>?>(
        () => super.postListByFileType,
        name: 'PostControllerBase.postListByFileType',
      )).value;

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isServerError: ${isServerError},
post: ${post},
postList: ${postList},
postListByFileType: ${postListByFileType}
    ''';
  }
}
