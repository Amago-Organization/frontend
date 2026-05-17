
import 'package:uikit/uikit.dart';

class EmailValueObject {
  final String value;

  EmailValueObject._(this.value);
  
  static final RegExp _regex = RegExp(RegexToken.email);

  factory EmailValueObject(String input) {
    if (!_regex.hasMatch(input)) {
      throw Exception('Email inválido');
    }

    return EmailValueObject._(input);
  }
}