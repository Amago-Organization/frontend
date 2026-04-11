import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pulse_post/app/features/domain/entities/user_entity.dart';
import 'package:pulse_post/app/features/domain/params/users/user_register_param.dart';
import 'package:pulse_post/app/features/domain/repositories/user_repository.dart';
import 'package:pulse_post/app/features/domain/usecases/users/user_usecase_register.dart';
import 'package:result_dart/result_dart.dart';

class UserRepositoryMock extends Mock implements UserRepository {}

void main() {
  late UserRepositoryMock repositoryMock;
  late UserUsecaseRegister usecase;

  setUp(() {
    repositoryMock = UserRepositoryMock();
    usecase = UserUsecaseRegister(userRepository: repositoryMock);
  });

  group("UserUsecaseRegister", () {
    late UserRegisterParam input;
    late UserEntity output;
    test("Deve registrar um novo usuário", () async {
      input = UserRegisterParam(
        name: "Lázaro",
        email: "lazaro@gmail.com",
        password: "1234",
      );

      output = UserEntity(
        id: "1",
        name: input.name,
        email: input.email,
        createdAt: "09/10/2025",
      );

      when(
        () => repositoryMock.register(input),
      ).thenAnswer((invocation) async => Success(output));

      final result = await usecase(input);

      expect(result.isSuccess(), isTrue);
      expect(result.getOrNull()?.name, equals("Lázaro"));

      verify(() => repositoryMock.register(input)).called(1);
    });

    test("Deve retornar erro ao registrar usuário", () async {
      input = UserRegisterParam(
        name: "Lázaro",
        email: "lazaro@gmail.com",
        password: "1234",
      );

      when(
        () => repositoryMock.register(input),
      ).thenAnswer((_) async => Failure(Exception("Erro ao registrar")));

      final result = await usecase(input);

      expect(result.isError(), isTrue);
      expect(result.exceptionOrNull(), isA<Exception>());

      verify(() => repositoryMock.register(input)).called(1);
    });
  });
}
