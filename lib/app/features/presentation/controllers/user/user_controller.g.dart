// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserController on UserControllerBase, Store {
  Computed<bool>? _$isTokenValidComputed;

  @override
  bool get isTokenValid => (_$isTokenValidComputed ??= Computed<bool>(
    () => super.isTokenValid,
    name: 'UserControllerBase.isTokenValid',
  )).value;
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??= Computed<bool>(
    () => super.isLoading,
    name: 'UserControllerBase.isLoading',
  )).value;
  Computed<bool>? _$isServerErrorComputed;

  @override
  bool get isServerError => (_$isServerErrorComputed ??= Computed<bool>(
    () => super.isServerError,
    name: 'UserControllerBase.isServerError',
  )).value;
  Computed<UserDetailDto?>? _$userComputed;

  @override
  UserDetailDto? get user => (_$userComputed ??= Computed<UserDetailDto?>(
    () => super.user,
    name: 'UserControllerBase.user',
  )).value;

  @override
  String toString() {
    return '''
isTokenValid: ${isTokenValid},
isLoading: ${isLoading},
isServerError: ${isServerError},
user: ${user}
    ''';
  }
}
