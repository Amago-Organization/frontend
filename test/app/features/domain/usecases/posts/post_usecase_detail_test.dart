import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pulse_post/app/features/data/models/user_summary_model.dart';
import 'package:pulse_post/app/features/domain/entities/post_entity.dart';
import 'package:pulse_post/app/features/domain/repositories/post_repository.dart';
import 'package:pulse_post/app/features/domain/usecases/posts/post_usecase_detail.dart';
import 'package:result_dart/result_dart.dart';

class PostRepositoryMock extends Mock implements PostRepository {}

void main() {
  late PostRepositoryMock repositoryMock;
  late PostUsecaseDetail usecase;

  setUp(() {
    repositoryMock = PostRepositoryMock();
    usecase = PostUsecaseDetail(postRepository: repositoryMock);
  });

  group("PostUsecaseDetail", () {
    late String input;
    late PostEntity output;

    test("Deve detalhar um post", () async {
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

      for (var element in list) {
        if (element.id == input) {
          output = element;
        }
      }

      when(
        () => repositoryMock.detail(input),
      ).thenAnswer((invocation) async => Success(output));

      final result = await usecase(input);

      expect(result.isSuccess(), isTrue);
      expect(result.getOrNull()?.id, equals("2"));
      expect(result.getOrNull()?.title, equals("titulo 2"));
      expect(result.getOrNull()?.description, equals("description 02"));
      expect(result.getOrNull()?.postType, equals("IMAGE"));
      expect(result.getOrNull()?.file, equals("image.png"));
      expect(result.getOrNull()?.createdAt, equals("10/09/2025"));
      expect(result.getOrNull()?.updateAt, equals(null));
      expect(result.getOrNull()?.user.id, equals("1"));
      expect(result.getOrNull()?.user.name, equals("name"));

      verify(() => repositoryMock.detail(input)).called(1);
    });

    test("Deve retornar erro ao detalhar um post", () async {
      input = "2";

      when(
        () => repositoryMock.detail(input),
      ).thenAnswer((_) async => Failure(Exception("Erro ao detalhar")));

      final result = await usecase(input);

      expect(result.isError(), isTrue);
      expect(result.exceptionOrNull(), isA<Exception>());

      verify(() => repositoryMock.detail(input)).called(1);
    });
  });
}
