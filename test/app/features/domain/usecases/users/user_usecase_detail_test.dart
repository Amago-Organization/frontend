import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pulse_post/app/core/usecase/usecase.dart';
import 'package:pulse_post/app/features/domain/entities/user_entity.dart';
import 'package:pulse_post/app/features/domain/repositories/user_repository.dart';
import 'package:pulse_post/app/features/domain/usecases/users/user_usecase_detail.dart';
import 'package:result_dart/result_dart.dart';

class UserRepositoryMock extends Mock implements UserRepository {}

void main() {
  late UserRepositoryMock repositoryMock;
  late UserUsecaseDetail usecase;

  setUp(() {
    repositoryMock = UserRepositoryMock();
    usecase = UserUsecaseDetail(userRepository: repositoryMock);
  });

  group("UserUsecaseDetail", () {
    late UserEntity output;
    test("Deve bucar dados do usário logado", () async {
      output = UserEntity(
        id: "1",
        name: "Lázaro",
        email: "lazaro@gmail.com",
        createdAt: "09/10/2025",
      );

      when(
        () => repositoryMock.detail(),
      ).thenAnswer((invocation) async => Success(output));

      final result = await usecase(NoParams());

      expect(result.isSuccess(), isTrue);
      expect(result.getOrNull()?.id, equals("1"));
      expect(result.getOrNull()?.name, equals("Lázaro"));
      expect(result.getOrNull()?.email, equals("lazaro@gmail.com"));
      expect(result.getOrNull()?.createdAt, equals("09/10/2025"));

      verify(() => repositoryMock.detail()).called(1);
    });

    test("Deve retornar erro ao bucar dados do usário logado", () async {
      when(
        () => repositoryMock.detail(),
      ).thenAnswer((_) async => Failure(Exception("Erro ao detalhar")));

      final result = await usecase(NoParams());

      expect(result.isError(), isTrue);
      expect(result.exceptionOrNull(), isA<Exception>());

      verify(() => repositoryMock.detail()).called(1);
    });
  });
}
