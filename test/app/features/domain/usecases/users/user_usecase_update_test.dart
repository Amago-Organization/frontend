import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pulse_post/app/features/domain/entities/user_entity.dart';
import 'package:pulse_post/app/features/domain/params/users/user_update_param.dart';
import 'package:pulse_post/app/features/domain/repositories/user_repository.dart';
import 'package:pulse_post/app/features/domain/usecases/users/user_usecase_update.dart';
import 'package:result_dart/result_dart.dart';

class UserRepositoryMock extends Mock implements UserRepository {}

void main() {
  late UserRepositoryMock repositoryMock;
  late UserUsecaseUpdate usecase;

  setUp(() {
    repositoryMock = UserRepositoryMock();
    usecase = UserUsecaseUpdate(userRepository: repositoryMock);
  });

  group("UserUsecaseUpdate", () {
    late UserEntity oldData;
    late UserUpdateParam input;
    late UserEntity output;
    test("Deve atualizar um usuário já existente", () async {
      oldData = UserEntity(
        id: "1",
        name: "Lázaro",
        email: "lazaro@gmail.com",
        createdAt: "09/10/2025",
      );

      input = UserUpdateParam(name: "Lázaro Luis");

      output = UserEntity(
        id: oldData.id,
        name: input.name ?? oldData.name,
        email: oldData.email,
        createdAt: oldData.createdAt,
        updatedAt: "10/10/2025",
      );

      when(
        () => repositoryMock.update(input),
      ).thenAnswer((invocation) async => Success(output));

      final result = await usecase(input);

      expect(result.isSuccess(), isTrue);
      expect(result.getOrNull()?.name, equals("Lázaro Luis"));
      expect(result.getOrNull()?.updatedAt, equals("10/10/2025"));

      verify(() => repositoryMock.update(input)).called(1);
    });

    test("Deve retornar erro ao atualizar um usuário já existente", () async {
      input = UserUpdateParam(name: "Lázaro Luis");

      when(
        () => repositoryMock.update(input),
      ).thenAnswer((_) async => Failure(Exception("Erro ao atualizar")));

      final result = await usecase(input);

      expect(result.isError(), isTrue);
      expect(result.exceptionOrNull(), isA<Exception>());

      verify(() => repositoryMock.update(input)).called(1);
    });
  });
}
