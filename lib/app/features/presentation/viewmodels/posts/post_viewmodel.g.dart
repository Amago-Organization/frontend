// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PostViewmodel on PostViewmodelBase, Store {
  late final _$isLoadingAtom = Atom(
    name: 'PostViewmodelBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$serverErrorAtom = Atom(
    name: 'PostViewmodelBase.serverError',
    context: context,
  );

  @override
  bool get serverError {
    _$serverErrorAtom.reportRead();
    return super.serverError;
  }

  @override
  set serverError(bool value) {
    _$serverErrorAtom.reportWrite(value, super.serverError, () {
      super.serverError = value;
    });
  }

  late final _$postAtom = Atom(
    name: 'PostViewmodelBase.post',
    context: context,
  );

  @override
  PostEntity? get post {
    _$postAtom.reportRead();
    return super.post;
  }

  @override
  set post(PostEntity? value) {
    _$postAtom.reportWrite(value, super.post, () {
      super.post = value;
    });
  }

  late final _$postListAtom = Atom(
    name: 'PostViewmodelBase.postList',
    context: context,
  );

  @override
  List<PostEntity>? get postList {
    _$postListAtom.reportRead();
    return super.postList;
  }

  @override
  set postList(List<PostEntity>? value) {
    _$postListAtom.reportWrite(value, super.postList, () {
      super.postList = value;
    });
  }

  late final _$postListByFileTypeAtom = Atom(
    name: 'PostViewmodelBase.postListByFileType',
    context: context,
  );

  @override
  List<PostEntity>? get postListByFileType {
    _$postListByFileTypeAtom.reportRead();
    return super.postListByFileType;
  }

  @override
  set postListByFileType(List<PostEntity>? value) {
    _$postListByFileTypeAtom.reportWrite(value, super.postListByFileType, () {
      super.postListByFileType = value;
    });
  }

  late final _$listAsyncAction = AsyncAction(
    'PostViewmodelBase.list',
    context: context,
  );

  @override
  Future<void> list() {
    return _$listAsyncAction.run(() => super.list());
  }

  late final _$listByFileTypeAsyncAction = AsyncAction(
    'PostViewmodelBase.listByFileType',
    context: context,
  );

  @override
  Future<void> listByFileType(String type) {
    return _$listByFileTypeAsyncAction.run(() => super.listByFileType(type));
  }

  late final _$detailAsyncAction = AsyncAction(
    'PostViewmodelBase.detail',
    context: context,
  );

  @override
  Future<void> detail(String id) {
    return _$detailAsyncAction.run(() => super.detail(id));
  }

  late final _$registerAsyncAction = AsyncAction(
    'PostViewmodelBase.register',
    context: context,
  );

  @override
  Future<void> register(PostRegisterParam data) {
    return _$registerAsyncAction.run(() => super.register(data));
  }

  late final _$updateAsyncAction = AsyncAction(
    'PostViewmodelBase.update',
    context: context,
  );

  @override
  Future<void> update(PostUpdateParam data) {
    return _$updateAsyncAction.run(() => super.update(data));
  }

  late final _$removeAsyncAction = AsyncAction(
    'PostViewmodelBase.remove',
    context: context,
  );

  @override
  Future<void> remove(String id) {
    return _$removeAsyncAction.run(() => super.remove(id));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
serverError: ${serverError},
post: ${post},
postList: ${postList},
postListByFileType: ${postListByFileType}
    ''';
  }
}
