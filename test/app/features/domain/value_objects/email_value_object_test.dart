import 'package:flutter_test/flutter_test.dart';
import 'package:amago/app/features/domain/value_objects/email_value_object.dart';

void main() {
  group("EmailValueObject", () {
    group("Emails válidos", () {
      test("Deve aceitar email simples", () {
        expect(() => EmailValueObject("user@example.com"), returnsNormally);
      });

      test("Deve aceitar email com números", () {
        expect(() => EmailValueObject("user123@example.com"), returnsNormally);
      });

      test("Deve aceitar email com pontos no local", () {
        expect(
          () => EmailValueObject("user.name@example.com"),
          returnsNormally,
        );
      });

      test("Deve aceitar email com hífens no local", () {
        expect(
          () => EmailValueObject("user-name@example.com"),
          returnsNormally,
        );
      });

      test("Deve aceitar email com underscore no local", () {
        expect(
          () => EmailValueObject("user_name@example.com"),
          returnsNormally,
        );
      });

      test("Deve aceitar email com subdomínio", () {
        expect(
          () => EmailValueObject("user@mail.example.com"),
          returnsNormally,
        );
      });

      test("Deve aceitar email com múltiplos subdomínios", () {
        expect(() => EmailValueObject("user@mail.co.uk"), returnsNormally);
      });

      test("Deve aceitar email com domínio simples", () {
        expect(() => EmailValueObject("user@example.io"), returnsNormally);
      });

      test("Deve aceitar email com números no domínio", () {
        expect(() => EmailValueObject("user@example123.com"), returnsNormally);
      });

      test("Deve aceitar email com maiúsculas (caso preservado)", () {
        expect(() => EmailValueObject("User@Example.COM"), returnsNormally);
      });
    });

    group("Emails inválidos - falta de @", () {
      test("Deve rejeitar email sem @", () {
        expect(() => EmailValueObject("userexample.com"), throwsException);
      });

      test("Deve rejeitar email com apenas local", () {
        expect(() => EmailValueObject("user"), throwsException);
      });
    });

    group("Emails inválidos - formato incorreto", () {
      test("Deve rejeitar email sem local", () {
        expect(() => EmailValueObject("@example.com"), throwsException);
      });

      test("Deve rejeitar email sem domínio", () {
        expect(() => EmailValueObject("user@"), throwsException);
      });

      test("Deve rejeitar email sem TLD", () {
        expect(() => EmailValueObject("user@example"), throwsException);
      });

      test("Deve rejeitar email com @ no final", () {
        expect(() => EmailValueObject("user.example.com@"), throwsException);
      });

      test("Deve rejeitar email com múltiplos @", () {
        expect(() => EmailValueObject("user@example@com"), throwsException);
      });
    });

    group("Emails inválidos - espaços em branco", () {
      test("Deve rejeitar email com espaço no local", () {
        expect(
          () => EmailValueObject("user name@example.com"),
          throwsException,
        );
      });

      test("Deve rejeitar email com espaço no domínio", () {
        expect(() => EmailValueObject("user@exam ple.com"), throwsException);
      });

      test("Deve rejeitar email com espaço antes de @", () {
        expect(() => EmailValueObject("user @example.com"), throwsException);
      });

      test("Deve rejeitar email com espaço depois de @", () {
        expect(() => EmailValueObject("user@ example.com"), throwsException);
      });

      test("Deve rejeitar email vazio", () {
        expect(() => EmailValueObject(""), throwsException);
      });

      test("Deve rejeitar email apenas com espaços", () {
        expect(() => EmailValueObject("   "), throwsException);
      });
    });

    group("Instância do EmailValueObject", () {
      test("Deve retornar o valor armazenado", () {
        final email = EmailValueObject("user@example.com");
        expect(email.value, equals("user@example.com"));
      });

      test("Deve preservar maiúsculas no valor", () {
        final email = EmailValueObject("User@Example.COM");
        expect(email.value, equals("User@Example.COM"));
      });
    });
  });
}
