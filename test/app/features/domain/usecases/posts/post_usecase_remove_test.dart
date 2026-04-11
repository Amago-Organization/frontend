import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pulse_post/app/features/data/models/user_summary_model.dart';
import 'package:pulse_post/app/features/domain/entities/post_entity.dart';
import 'package:pulse_post/app/features/domain/repositories/post_repository.dart';
import 'package:pulse_post/app/features/domain/usecases/posts/post_usecase_remove.dart';
import 'package:result_dart/result_dart.dart';

class PostRepositoryMock extends Mock implements PostRepository {}

void main() {
  late PostRepositoryMock repositoryMock;
  late PostUsecaseRemove usecase;

  setUp(() {
    repositoryMock = PostRepositoryMock();
    usecase = PostUsecaseRemove(postRepository: repositoryMock);
  });

  group("PostUsecaseRemove", () {
    late String input;
    test("Deve remover um post", () async {
      final List<PostEntity> list = [
        PostEntity(
          id: "1",
          title: "titulo 1",
          description: "description 01",
          postType: "TEXT",
          file: null,
          createdAt: "10/09/2025",
          updateAt: null,
          user: UserSummaryModel(id: "1", name: "name"),
        ),
        PostEntity(
          id: "2",
          title: "titulo 2",
          description: "description 02",
          postType: "IMAGE",
          file: "image.png",
          createdAt: "10/09/2025",
          updateAt: null,
          user: UserSummaryModel(id: "1", name: "name"),
        ),
        PostEntity(
          id: "3",
          title: "titulo 3",
          description: "description 03",
          postType: "VIDEO",
          file: "video.mp4",
          createdAt: "10/09/2025",
          updateAt: null,
          user: UserSummaryModel(id: "1", name: "name"),
        ),
      ];

      input = "2";

      list.removeWhere((element) => element.id == input);

      when(
        () => repositoryMock.remove(input),
      ).thenAnswer((invocation) async => Success(Unit));

      final result = await usecase(input);

      expect(result.isSuccess(), isTrue);
      expect(list.length, 2);
      expect(list.any((element) => element.id == "2"), isFalse);

      verify(() => repositoryMock.remove(input)).called(1);
    });

    test("Deve retornar erro ao remover um post", () async {
      input = "2";

      when(
        () => repositoryMock.remove(input),
      ).thenAnswer((_) async => Failure(Exception("Erro ao remover")));

      final result = await usecase(input);

      expect(result.isError(), isTrue);
      expect(result.exceptionOrNull(), isA<Exception>());

      verify(() => repositoryMock.remove(input)).called(1);
    });
  });
}
