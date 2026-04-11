import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pulse_post/app/features/data/models/user_summary_model.dart';
import 'package:pulse_post/app/features/domain/entities/post_entity.dart';
import 'package:pulse_post/app/features/domain/params/posts/post_update_param.dart';
import 'package:pulse_post/app/features/domain/repositories/post_repository.dart';
import 'package:pulse_post/app/features/domain/usecases/posts/post_usecase_update.dart';
import 'package:result_dart/result_dart.dart';

class PostRepositoryMock extends Mock implements PostRepository {}

void main() {
  late PostRepositoryMock repositoryMock;
  late PostUsecaseUpdate usecase;

  setUp(() {
    repositoryMock = PostRepositoryMock();
    usecase = PostUsecaseUpdate(postRepository: repositoryMock);
  });

  group("PostUsecaseUpdate", () {
    late PostUpdateParam input;
    late PostEntity output;
    late PostEntity oldData;

    test("Deve atualizar um post", () async {
      oldData = PostEntity(
        id: "1",
        title: "title 1",
        description: "description 1",
        postType: "TEXT",
        createdAt: "10/09/2025",
        user: UserSummaryModel(id: "1", name: "name"),
      );

      input = PostUpdateParam(id: "1", title: "title updated");

      output = PostEntity(
        id: oldData.id,
        title: input.title ?? oldData.title,
        description: oldData.description,
        postType: oldData.postType,
        createdAt: oldData.createdAt,
        updateAt: "10/10/2025",
        user: UserSummaryModel(id: "1", name: "name"),
      );

      when(
        () => repositoryMock.update(input),
      ).thenAnswer((invocation) async => Success(output));

      final result = await usecase(input);

      expect(result.isSuccess(), isTrue);
      expect(result.getOrNull()?.title, equals("title updated"));
      expect(result.getOrNull()?.description, equals("description 1"));
      expect(result.getOrNull()?.updateAt, equals("10/10/2025"));

      verify(() => repositoryMock.update(input)).called(1);
    });

    test("Deve retornar erro ao atualizar um post", () async {
      input = PostUpdateParam(id: "1", title: "title atualizado");

      when(
        () => repositoryMock.update(input),
      ).thenAnswer((_) async => Failure(Exception("Erro ao registrar")));

      final result = await usecase(input);

      expect(result.isError(), isTrue);
      expect(result.exceptionOrNull(), isA<Exception>());

      verify(() => repositoryMock.update(input)).called(1);
    });
  });
}
