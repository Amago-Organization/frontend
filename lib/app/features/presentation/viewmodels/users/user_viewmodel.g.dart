// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserViewmodel on UserViewmodelBase, Store {
  late final _$tokenAtom = Atom(
    name: 'UserViewmodelBase.token',
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
    name: 'UserViewmodelBase.isLoading',
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

  late final _$userAtom = Atom(
    name: 'UserViewmodelBase.user',
    context: context,
  );

  @override
  UserEntity? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserEntity? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$serverErrorAtom = Atom(
    name: 'UserViewmodelBase.serverError',
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
    'UserViewmodelBase.login',
    context: context,
  );

  @override
  Future<void> login(UserLoginParam data) {
    return _$loginAsyncAction.run(() => super.login(data));
  }

  late final _$registerAsyncAction = AsyncAction(
    'UserViewmodelBase.register',
    context: context,
  );

  @override
  Future<void> register(UserRegisterParam data) {
    return _$registerAsyncAction.run(() => super.register(data));
  }

  late final _$detailsAsyncAction = AsyncAction(
    'UserViewmodelBase.details',
    context: context,
  );

  @override
  Future<void> details() {
    return _$detailsAsyncAction.run(() => super.details());
  }

  late final _$updateAsyncAction = AsyncAction(
    'UserViewmodelBase.update',
    context: context,
  );

  @override
  Future<void> update(UserUpdateParam data) {
    return _$updateAsyncAction.run(() => super.update(data));
  }

  late final _$logoutAsyncAction = AsyncAction(
    'UserViewmodelBase.logout',
    context: context,
  );

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$loadTokenAsyncAction = AsyncAction(
    'UserViewmodelBase.loadToken',
    context: context,
  );

  @override
  Future<void> loadToken() {
    return _$loadTokenAsyncAction.run(() => super.loadToken());
  }

  @override
  String toString() {
    return '''
token: ${token},
isLoading: ${isLoading},
user: ${user},
serverError: ${serverError}
    ''';
  }
}
