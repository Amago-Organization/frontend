// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserViewModel on UserViewModelBase, Store {
  late final _$tokenAtom = Atom(
    name: 'UserViewModelBase.token',
    context: context,
  );

  @override
  String? get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String? value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: 'UserViewModelBase.isLoading',
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

  late final _$userDetailDtoAtom = Atom(
    name: 'UserViewModelBase.userDetailDto',
    context: context,
  );

  @override
  UserDetailDto? get userDetailDto {
    _$userDetailDtoAtom.reportRead();
    return super.userDetailDto;
  }

  @override
  set userDetailDto(UserDetailDto? value) {
    _$userDetailDtoAtom.reportWrite(value, super.userDetailDto, () {
      super.userDetailDto = value;
    });
  }

  late final _$serverErrorAtom = Atom(
    name: 'UserViewModelBase.serverError',
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

  late final _$loginAsyncAction = AsyncAction(
    'UserViewModelBase.login',
    context: context,
  );

  @override
  Future<void> login(UserLoginDto data) {
    return _$loginAsyncAction.run(() => super.login(data));
  }

  late final _$registerAsyncAction = AsyncAction(
    'UserViewModelBase.register',
    context: context,
  );

  @override
  Future<dynamic> register(UserRegisterDto data) {
    return _$registerAsyncAction.run(() => super.register(data));
  }

  late final _$logoutAsyncAction = AsyncAction(
    'UserViewModelBase.logout',
    context: context,
  );

  @override
  Future<dynamic> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$detailsAsyncAction = AsyncAction(
    'UserViewModelBase.details',
    context: context,
  );

  @override
  Future<dynamic> details() {
    return _$detailsAsyncAction.run(() => super.details());
  }

  late final _$loadTokenAsyncAction = AsyncAction(
    'UserViewModelBase.loadToken',
    context: context,
  );

  @override
  Future<void> loadToken() {
    return _$loadTokenAsyncAction.run(() => super.loadToken());
  }

  late final _$updateAsyncAction = AsyncAction(
    'UserViewModelBase.update',
    context: context,
  );

  @override
  Future<dynamic> update(UserUpdateDto data, File? file) {
    return _$updateAsyncAction.run(() => super.update(data, file));
  }

  @override
  String toString() {
    return '''
token: ${token},
isLoading: ${isLoading},
userDetailDto: ${userDetailDto},
serverError: ${serverError}
    ''';
  }
}
