import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pulse_post/app/features/data/models/user_summary_model.dart';
import 'package:pulse_post/app/features/domain/entities/post_entity.dart';
import 'package:pulse_post/app/features/domain/params/posts/post_register_param.dart';
import 'package:pulse_post/app/features/domain/repositories/post_repository.dart';
import 'package:pulse_post/app/features/domain/usecases/posts/post_usecase_register.dart';
import 'package:result_dart/result_dart.dart';

class PostRepositoryMock extends Mock implements PostRepository {}

void main() {
  late PostRepositoryMock repositoryMock;
  late PostUsecaseRegister usecase;

  setUp(() {
    repositoryMock = PostRepositoryMock();
    usecase = PostUsecaseRegister(postRepository: repositoryMock);
  });

  group("PostUsecaseRegister", () {
    late PostRegisterParam input;
    late PostEntity output;
    test("Deve registrar um novo post", () async {
      input = PostRegisterParam(title: "title 1", description: "description 1");

      output = PostEntity(
        id: "1",
        title: input.title,
        description: input.description,
        postType: "TEXT",
        file: null,
        createdAt: "10/09/2025",
        updateAt: null,
        user: UserSummaryModel(id: "1", name: "name"),
      );

      when(
        () => repositoryMock.register(input),
      ).thenAnswer((invocation) async => Success(output));

      final result = await usecase(input);

      expect(result.isSuccess(), isTrue);
      expect(result.getOrNull()?.title, equals("title 1"));
      expect(result.getOrNull()?.description, equals("description 1"));

      verify(() => repositoryMock.register(input)).called(1);
    });

    test("Deve retornar erro ao registrar post", () async {
      input = PostRegisterParam(title: "title 1", description: "description 1");

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
