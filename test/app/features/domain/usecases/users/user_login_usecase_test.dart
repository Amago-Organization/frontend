import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:amago/app/features/domain/params/users/user_login_param.dart';
import 'package:amago/app/features/domain/repositories/user_repository.dart';
import 'package:amago/app/features/domain/usecases/users/user_usecase_login.dart';
import 'package:result_dart/result_dart.dart';

class UserRepositoryMock extends Mock implements UserRepository {}

void main() {
  late UserRepositoryMock repositoryMock;
  late UserUsecaseLogin usecase;

  setUp(() {
    repositoryMock = UserRepositoryMock();
    usecase = UserUsecaseLogin(userRepository: repositoryMock);
  });

  group("UserUsecaseLogin", () {
    late UserLoginParam input;
    late String output;
    test("Deve fAzer login de usuário", () async {
      input = UserLoginParam(email: "lazaro@gmail.com", password: "1234");

      output = "token_válido";

      when(
        () => repositoryMock.login(input),
      ).thenAnswer((invocation) async => Success(output));

      final result = await usecase(input);

      expect(result.isSuccess(), isTrue);
      expect(result.getOrNull(), equals("token_válido"));

      verify(() => repositoryMock.login(input)).called(1);
    });

    test("Deve retornar erro ao fazer login de usuário", () async {
      input = UserLoginParam(email: "lazaro@gmail.com", password: "1234");

      when(
        () => repositoryMock.login(input),
      ).thenAnswer((_) async => Failure(Exception("Erro ao fazer login")));

      final result = await usecase(input);

      expect(result.isError(), isTrue);
      expect(result.exceptionOrNull(), isA<Exception>());

      verify(() => repositoryMock.login(input)).called(1);
    });
  });
}
