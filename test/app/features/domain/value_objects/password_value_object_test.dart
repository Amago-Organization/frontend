import 'package:flutter_test/flutter_test.dart';
import 'package:amago/app/features/domain/value_objects/password_value_object.dart';

void main() {
  group('PasswordValueObject', () {
    group('Senhas válidas', () {
      test('Deve aceitar senha com 6 caracteres', () {
        expect(
          () => PasswordValueObject('Abc1!@'),
          returnsNormally,
        );
      });

      test('Deve aceitar senha com 10 caracteres', () {
        expect(
          () => PasswordValueObject('Abc1234!@#'),
          returnsNormally,
        );
      });

      test('Deve aceitar senha com tamanho intermediário', () {
        expect(
          () => PasswordValueObject('Abc123!@'),
          returnsNormally,
        );
      });

      test('Deve armazenar o valor corretamente', () {
        final password = PasswordValueObject(
          'Abc123!@',
        );

        expect(
          password.value,
          equals('Abc123!@'),
        );
      });
    });

    group('Tamanho inválido', () {
      test('Deve rejeitar menos de 6 caracteres', () {
        expect(
          () => PasswordValueObject('Ab1!'),
          throwsException,
        );
      });

      test('Deve rejeitar string vazia', () {
        expect(
          () => PasswordValueObject(''),
          throwsException,
        );
      });

      test('Deve rejeitar mais de 10 caracteres', () {
        expect(
          () => PasswordValueObject(
            'Abc12345!@#',
          ),
          throwsException,
        );
      });
    });

    group('Critérios obrigatórios ausentes', () {
      test('Deve rejeitar sem letra maiúscula', () {
        expect(
          () => PasswordValueObject('abc123!'),
          throwsException,
        );
      });

      test('Deve rejeitar sem letra minúscula', () {
        expect(
          () => PasswordValueObject('ABC123!'),
          throwsException,
        );
      });

      test('Deve rejeitar sem número', () {
        expect(
          () => PasswordValueObject('Abcdef!'),
          throwsException,
        );
      });

      test('Deve rejeitar sem caractere especial', () {
        expect(
          () => PasswordValueObject('Abc12345'),
          throwsException,
        );
      });
    });

    group('Múltiplas violações', () {
      test('Deve rejeitar senha totalmente inválida', () {
        expect(
          () => PasswordValueObject('abc'),
          throwsException,
        );
      });

      test('Deve rejeitar sem maiúscula e sem número', () {
        expect(
          () => PasswordValueObject('abcdef!'),
          throwsException,
        );
      });
    });
  });
}