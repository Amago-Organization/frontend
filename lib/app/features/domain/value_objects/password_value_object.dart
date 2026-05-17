import 'package:uikit/uikit.dart';

final class PasswordValueObject {
  final String value;

  PasswordValueObject._(this.value);

  static final RegExp _regex = RegExp(
    RegexToken.password,
  );

  factory PasswordValueObject(String input) {
    if (!_regex.hasMatch(input)) {
      throw Exception('Senha inválida');
    }

    return PasswordValueObject._(input);
  }
}