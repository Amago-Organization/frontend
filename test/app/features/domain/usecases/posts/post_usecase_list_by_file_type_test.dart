import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pulse_post/app/features/data/models/user_summary_model.dart';
import 'package:pulse_post/app/features/domain/entities/post_entity.dart';
import 'package:pulse_post/app/features/domain/repositories/post_repository.dart';
import 'package:pulse_post/app/features/domain/usecases/posts/post_usecase_list_by_file_type.dart';
import 'package:result_dart/result_dart.dart';

class PostRepositoryMock extends Mock implements PostRepository {}

void main() {
  late PostRepositoryMock repositoryMock;
  late PostUsecaseListByFileType usecase;

  setUp(() {
    repositoryMock = PostRepositoryMock();
    usecase = PostUsecaseListByFileType(postRepository: repositoryMock);
  });

  group("PostUsecaseList", () {
    late List<PostEntity> output;
    late String input;

    group("TEXT", () {
      test("Deve listar todos os meus posts de 'TEXT'", () async {
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
          PostEntity(
            id: "4",
            title: "titulo 4",
            description: "description 04",
            postType: "IMAGE",
            file: "image.png",
            createdAt: "10/09/2025",
            updateAt: null,
            user: UserSummaryModel(id: "1", name: "name"),
          ),
        ];

        input = "TEXT";
        output = list.where((element) => element.postType == input).toList();

        when(
          () => repositoryMock.listByFileType(input),
        ).thenAnswer((invocation) async => Success(output));

        final result = await usecase(input);

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull()?.length, equals(1));
        expect(
          result.getOrNull()?.any((element) => element.postType != "TEXT"),
          isFalse,
        );

        verify(() => repositoryMock.listByFileType(input)).called(1);
      });

      test(
        "Deve retornar erro ao listar todos os meus posts de 'TEXT''",
        () async {
          input = "TEXT";
          when(
            () => repositoryMock.listByFileType(input),
          ).thenAnswer((_) async => Failure(Exception("Erro ao listar")));

          final result = await usecase(input);

          expect(result.isError(), isTrue);
          expect(result.exceptionOrNull(), isA<Exception>());

          verify(() => repositoryMock.listByFileType(input)).called(1);
        },
      );
    });

    group("IMAGE", () {
      test("Deve listar todos os meus posts de 'IMAGE'", () async {
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
          PostEntity(
            id: "4",
            title: "titulo 4",
            description: "description 04",
            postType: "IMAGE",
            file: "image.png",
            createdAt: "10/09/2025",
            updateAt: null,
            user: UserSummaryModel(id: "1", name: "name"),
          ),
        ];
        input = "IMAGE";
        output = list.where((element) => element.postType == input).toList();

        when(
          () => repositoryMock.listByFileType(input),
        ).thenAnswer((invocation) async => Success(output));

        final result = await usecase(input);

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull()?.length, equals(2));
        expect(
          result.getOrNull()?.any((element) => element.postType != "IMAGE"),
          isFalse,
        );

        verify(() => repositoryMock.listByFileType(input)).called(1);
      });
      test(
        "Deve retornar erro ao listar todos os meus posts de 'IMAGE'",
        () async {
          input = "IMAGE";
          when(
            () => repositoryMock.listByFileType(input),
          ).thenAnswer((_) async => Failure(Exception("Erro ao listar")));

          final result = await usecase(input);

          expect(result.isError(), isTrue);
          expect(result.exceptionOrNull(), isA<Exception>());

          verify(() => repositoryMock.listByFileType(input)).called(1);
        },
      );
    });

    group("VIDEO", () {
      test("Deve listar todos os meus posts de 'VIDEO'", () async {
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
          PostEntity(
            id: "4",
            title: "titulo 4",
            description: "description 04",
            postType: "IMAGE",
            file: "image.png",
            createdAt: "10/09/2025",
            updateAt: null,
            user: UserSummaryModel(id: "1", name: "name"),
          ),
        ];
        input = "VIDEO";
        output = list.where((element) => element.postType == input).toList();

        when(
          () => repositoryMock.listByFileType(input),
        ).thenAnswer((invocation) async => Success(output));

        final result = await usecase(input);

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull()?.length, equals(1));
        expect(
          result.getOrNull()?.any((element) => element.postType != "VIDEO"),
          isFalse,
        );

        verify(() => repositoryMock.listByFileType(input)).called(1);
      });

      test(
        "Deve retornar erro ao listar todos os meus posts de 'VIDEO'",
        () async {
          input = "VIDEO";
          when(
            () => repositoryMock.listByFileType(input),
          ).thenAnswer((_) async => Failure(Exception("Erro ao listar")));

          final result = await usecase(input);

          expect(result.isError(), isTrue);
          expect(result.exceptionOrNull(), isA<Exception>());

          verify(() => repositoryMock.listByFileType(input)).called(1);
        },
      );
    });
  });
}
