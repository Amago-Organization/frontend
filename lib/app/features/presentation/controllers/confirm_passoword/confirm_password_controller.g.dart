// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_password_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConfirmPasswordController on ConfirmPasswordControllerBase, Store {
  Computed<bool>? _$passwordsMatchComputed;

  @override
  bool get passwordsMatch => (_$passwordsMatchComputed ??= Computed<bool>(
    () => super.passwordsMatch,
    name: 'ConfirmPasswordControllerBase.passwordsMatch',
  )).value;

  late final _$passwordAtom = Atom(
    name: 'ConfirmPasswordControllerBase.password',
    context: context,
  );

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$confirmPasswordAtom = Atom(
    name: 'ConfirmPasswordControllerBase.confirmPassword',
    context: context,
  );

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  late final _$ConfirmPasswordControllerBaseActionController = ActionController(
    name: 'ConfirmPasswordControllerBase',
    context: context,
  );

  @override
  void setPassword(String value) {
    final _$actionInfo = _$ConfirmPasswordControllerBaseActionController
        .startAction(name: 'ConfirmPasswordControllerBase.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$ConfirmPasswordControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmPassword(String value) {
    final _$actionInfo = _$ConfirmPasswordControllerBaseActionController
        .startAction(name: 'ConfirmPasswordControllerBase.setConfirmPassword');
    try {
      return super.setConfirmPassword(value);
    } finally {
      _$ConfirmPasswordControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
password: ${password},
confirmPassword: ${confirmPassword},
passwordsMatch: ${passwordsMatch}
    ''';
  }
}
