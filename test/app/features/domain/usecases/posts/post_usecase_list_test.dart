import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pulse_post/app/core/usecase/usecase.dart';
import 'package:pulse_post/app/features/data/models/user_summary_model.dart';
import 'package:pulse_post/app/features/domain/entities/post_entity.dart';
import 'package:pulse_post/app/features/domain/repositories/post_repository.dart';
import 'package:pulse_post/app/features/domain/usecases/posts/post_usecase_list.dart';
import 'package:result_dart/result_dart.dart';

class PostRepositoryMock extends Mock implements PostRepository {}

void main() {
  late PostRepositoryMock repositoryMock;
  late PostUsecaseList usecase;

  setUp(() {
    repositoryMock = PostRepositoryMock();
    usecase = PostUsecaseList(postRepository: repositoryMock);
  });

  group("PostUsecaseList", () {
    late List<PostEntity> output;
    test("Deve listar todos os posts criados", () async {
      output = [
        PostEntity(
          id: "1",
          title: "titulo 1",
          description: "description 01",
          postType: "TEXT",
          file: null,
          createdAt: "10/09/2025",
          updateAt: null,
                    user: UserSummaryModel(id: "1", name: "name")

        ),
        PostEntity(
          id: "2",
          title: "titulo 2",
          description: "description 02",
          postType: "IMAGE",
          file: "image.png",
          createdAt: "10/09/2025",
          updateAt: null,
                    user: UserSummaryModel(id: "1", name: "name")

        ),
        PostEntity(
          id: "3",
          title: "titulo 3",
          description: "description 03",
          postType: "VIDEO",
          file: "video.mp4",
          createdAt: "10/09/2025",
          updateAt: null,
                    user: UserSummaryModel(id: "1", name: "name")

        ),
      ];

      when(
        () => repositoryMock.list(),
      ).thenAnswer((invocation) async => Success(output));

      final result = await usecase(NoParams());

      expect(result.isSuccess(), isTrue);
      expect(result.getOrNull()?.length, equals(3));
      expect(result.getOrNull()?[1].postType, equals("IMAGE"));

      verify(() => repositoryMock.list()).called(1);
    });

    test("Deve retornar erro ao listar todos os posts criados", () async {

      when(
        () => repositoryMock.list(),
      ).thenAnswer((_) async => Failure(Exception("Erro ao listar")));

      final result = await usecase(NoParams());

      expect(result.isError(), isTrue);
      expect(result.exceptionOrNull(), isA<Exception>());

      verify(() => repositoryMock.list()).called(1);
    });
  });
}
