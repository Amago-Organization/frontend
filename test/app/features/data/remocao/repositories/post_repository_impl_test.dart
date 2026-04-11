import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pulse_post/app/features/data/remocao/repositories/post_repository_impl.dart';
import 'package:pulse_post/app/core/services/client/client_service.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/post/post_detail_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/post/post_register_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/post/post_update_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/user/user_summary_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/repositories/post_repository.dart';

class ClientServiceMock extends Mock implements ClientService {}

void main() {
  late ClientServiceMock clientServiceMock;
  late PostRepository postRepository;
  late Map<String, dynamic> database = {
    "posts": [
      {
        "id": "c1fa257d-9cc5-4c14-ab5a-ffb336b2aac8",
        "title": "hahah ",
        "description": "hajaja 1234",
        "postType": "IMAGE",
        "file":
            "https://res.cloudinary.com/dk0mrcf6d/image/upload/v1768244060/image/null.jpg",
        "createdAt": "2026-01-12T15:54:19.568372",
        "updatedAt": "2026-01-12T20:52:13.295114",
        "user": {
          "id": "948ed3e1-84e6-48a6-909a-ddb4228dd34f",
          "name": "Luis",
          "image":
              "https://res.cloudinary.com/dk0mrcf6d/image/upload/v1767991773/image/948ed3e1-84e6-48a6-909a-ddb4228dd34f.jpg",
        },
      },
      {
        "id": "3e9ef2f9-c3e6-4d5b-8208-89d4907a89ec",
        "title": "hoi",
        "description": "jajskak",
        "postType": "VIDEO",
        "file":
            "https://res.cloudinary.com/dk0mrcf6d/video/upload/v1768243936/video/null.mp4",
        "createdAt": "2026-01-12T15:52:14.254458",
        "updatedAt": null,
        "user": {
          "id": "948ed3e1-84e6-48a6-909a-ddb4228dd34f",
          "name": "Luis",
          "image":
              "https://res.cloudinary.com/dk0mrcf6d/image/upload/v1767991773/image/948ed3e1-84e6-48a6-909a-ddb4228dd34f.jpg",
        },
      },
      {
        "id": "1e475dea-2221-4ef7-9b41-373cc2456955",
        "title": "Texatndo ",
        "description": "Texas sks",
        "postType": "TEXT",
        "file": null,
        "createdAt": "2026-01-12T15:50:58.493221",
        "updatedAt": null,
        "user": {
          "id": "948ed3e1-84e6-48a6-909a-ddb4228dd34f",
          "name": "Luis",
          "image":
              "https://res.cloudinary.com/dk0mrcf6d/image/upload/v1767991773/image/948ed3e1-84e6-48a6-909a-ddb4228dd34f.jpg",
        },
      },
      {
        "id": "6a2c451c-f4d9-48c7-9e29-a1ecbb809b03",
        "title": "CuzCuz",
        "description": "pp",
        "postType": "IMAGE",
        "file":
            "https://res.cloudinary.com/dk0mrcf6d/image/upload/v1768262085/image/6a2c451c-f4d9-48c7-9e29-a1ecbb809b03.jpg",
        "createdAt": "2026-01-12T17:29:51.717094",
        "updatedAt": "2026-01-12T20:54:44.341923",
        "user": {
          "id": "948ed3e1-84e6-48a6-909a-ddb4228dd34f",
          "name": "Luis",
          "image":
              "https://res.cloudinary.com/dk0mrcf6d/image/upload/v1767991773/image/948ed3e1-84e6-48a6-909a-ddb4228dd34f.jpg",
        },
      },
    ],
  };

  setUp(() {
    clientServiceMock = ClientServiceMock();
    postRepository = PostRepositoryImpl(clientService: clientServiceMock);
  });

  group("PostRepositoryImpl", () {
    group("List", () {
      test("Listando todos os posts", () async {
        final response = Response(
          requestOptions: RequestOptions(),
          data: database,
        );

        when(
          () => clientServiceMock.get(any(), requiresAuth: true),
        ).thenAnswer((invocation) async => response);

        final result = await postRepository.list();

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), isA<List<PostDetailDto>>());
        expect(result.getOrNull()?.length, equals(4));
        verify(
          () => clientServiceMock.get(any(), requiresAuth: true),
        ).called(1);
      });
    });

    group("ListByFileType", () {
      test("Listando todos os posts do tipo 'TEXT'", () async {
        final databaseType = {
          "posts": (database["posts"] as List)
              .where((element) => element['postType'] == "TEXT")
              .toList(),
        };

        final response = Response(
          requestOptions: RequestOptions(),
          data: databaseType,
        );

        when(
          () => clientServiceMock.get(any(), requiresAuth: true),
        ).thenAnswer((invocation) async => response);

        final result = await postRepository.listByFileType("TEXT");

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), isA<List<PostDetailDto>>());
        expect(result.getOrNull()?.length, equals(1));
        verify(
          () => clientServiceMock.get(any(), requiresAuth: true),
        ).called(1);
      });

      test("Listando todos os posts do tipo 'IMAGE'", () async {
        final databaseType = {
          "posts": (database["posts"] as List)
              .where((element) => element['postType'] == "IMAGE")
              .toList(),
        };

        final response = Response(
          requestOptions: RequestOptions(),
          data: databaseType,
        );

        when(
          () => clientServiceMock.get(any(), requiresAuth: true),
        ).thenAnswer((invocation) async => response);

        final result = await postRepository.listByFileType("IMAGE");

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), isA<List<PostDetailDto>>());
        expect(result.getOrNull()?.length, equals(2));
        verify(
          () => clientServiceMock.get(any(), requiresAuth: true),
        ).called(1);
      });

      test("Listando todos os posts do tipo 'VIDEO'", () async {
        final databaseType = {
          "posts": (database["posts"] as List)
              .where((element) => element['postType'] == "VIDEO")
              .toList(),
        };

        final response = Response(
          requestOptions: RequestOptions(),
          data: databaseType,
        );

        when(
          () => clientServiceMock.get(any(), requiresAuth: true),
        ).thenAnswer((invocation) async => response);

        final result = await postRepository.listByFileType("VIDEO");

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), isA<List<PostDetailDto>>());
        expect(result.getOrNull()?.length, equals(1));
        verify(
          () => clientServiceMock.get(any(), requiresAuth: true),
        ).called(1);
      });
    });

    group("Detail", () {
      late PostDetailDto postDetailDto;
      test("Detalhes Corretos do Post", () async {
        final id = "3e9ef2f9-c3e6-4d5b-8208-89d4907a89ec";
        postDetailDto = PostDetailDto.fromMap((database["posts"] as List)[1]);

        final response = Response(
          requestOptions: RequestOptions(),
          data: postDetailDto.toMap(),
        );

        when(
          () => clientServiceMock.get(any(), requiresAuth: true),
        ).thenAnswer((invocation) async => response);

        final result = await postRepository.detail(id);

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), isA<PostDetailDto>());
        expect(result.getOrNull()?.id, equals(id));
        expect(result.getOrNull()?.title, equals("hoi"));

        verify(
          () => clientServiceMock.get(any(), requiresAuth: true),
        ).called(1);
      });
    });

    group("Register", () {
      late PostRegisterDto postRegisterDto;
      late PostDetailDto postDetailDto;

      test("Novo Post", () async {
        postRegisterDto = PostRegisterDto(
          title: "New title",
          description: "New description",
        );

        postDetailDto = PostDetailDto(
          id: "4e9ef2f9-c3e6-4d5b-8208-89d4907a89ec",
          title: postRegisterDto.title,
          description: postRegisterDto.description,
          postType: "TEXT",
          createdAt: "2026-01-12T15:54:19.568372",
          file: null,
          updatedAt: null,
          user: UserSummaryDto(
            id: "948ed3e1-84e6-48a6-909a-ddb4228dd34f",
            name: "Luis",
            image: null,
          ),
        );

        final response = Response(
          requestOptions: RequestOptions(),
          data: postDetailDto.toMap(),
        );

        when(
          () => clientServiceMock.post(
            any(),
            any(),
            requiresAuth: true,
            contentType: 'multipart/form-data',
          ),
        ).thenAnswer((invocation) async => response);

        final result = await postRepository.register(postRegisterDto, null);

        (database["posts"] as List).add(postDetailDto.toMap());

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), isA<PostDetailDto>());
        expect(result.getOrNull()?.id, equals(postDetailDto.id));
        expect(
          (database["posts"] as List).any(
            (element) =>
                element['id'] == postDetailDto.id &&
                element['title'] == postDetailDto.title &&
                element['description'] == postDetailDto.description,
          ),
          isTrue,
        );

        verify(
          () => clientServiceMock.post(
            any(),
            any(),
            requiresAuth: true,
            contentType: 'multipart/form-data',
          ),
        ).called(1);
      });
    });
    group("Update", () {
      late PostUpdateDto postUpdateDto;
      late PostDetailDto postDetailDto;
      late String id;
      test("Atualizando Dados de Post", () async {
        postUpdateDto = PostUpdateDto(title: "Título Teste");
        id = '6a2c451c-f4d9-48c7-9e29-a1ecbb809b03';
        for (var element in database['posts']) {
          if (element['id'] == id) {
            element['title'] = postUpdateDto.title;
            postDetailDto = PostDetailDto.fromMap(element);
          }
        }

        final response = Response(
          requestOptions: RequestOptions(),
          data: postDetailDto.toMap(),
        );

        when(
          () => clientServiceMock.patch(
            any(),
            any(),
            requiresAuth: true,
            contentType: 'multipart/form-data',
          ),
        ).thenAnswer((_) async => response);

        final result = await postRepository.update(
          postDetailDto.id,
          postUpdateDto,
          null,
        );

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), isA<PostDetailDto>());
        expect(result.getOrNull()?.title, equals(postDetailDto.title));
        expect(result.getOrNull()?.title, equals("Título Teste"));
        expect(result.getOrNull()?.id, equals(postDetailDto.id));

        verify(
          () => clientServiceMock.patch(
            any(),
            any(),
            requiresAuth: true,
            contentType: 'multipart/form-data',
          ),
        ).called(1);
      });
    });

    group("Remove", () {
      late String id;

      test("Removendo um Post", () async {
        id = '6a2c451c-f4d9-48c7-9e29-a1ecbb809b03';
        final response = Response(requestOptions: RequestOptions(), data: null);

        (database['posts'] as List).removeWhere((post) => post['id'] == id);

        when(
          () => clientServiceMock.delete(any(), requiresAuth: true),
        ).thenAnswer((invocation) async => response);

        final result = await postRepository.remove(id);

        expect(result.isSuccess(), isTrue);
        expect(
          (database['posts'] as List).any((element) => id == element['id']),
          isFalse,
        );

        verify(
          () => clientServiceMock.delete(any(), requiresAuth: true),
        ).called(1);
      });
    });
  });
}
