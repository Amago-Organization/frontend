import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pulse_post/app/core/services/messages/result_message_service.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/post/post_detail_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/post/post_register_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/post/post_update_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/user/user_summary_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/repositories/post_repository.dart';
import 'package:pulse_post/app/features/presentation/viewmodels/remocao/posts/post_view_model.dart';
import 'package:result_dart/result_dart.dart';

class PostRepositoryMock extends Mock implements PostRepository {}

class ResultMessageServiceMock extends Mock implements ResultMessageService {}

void main() {
  late PostRepositoryMock postRepositoryMock;
  late ResultMessageServiceMock resultMessageServiceMock;
  late PostViewModel postViewModel;
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
    postRepositoryMock = PostRepositoryMock();
    resultMessageServiceMock = ResultMessageServiceMock();
    postViewModel = PostViewModel(
      postRepository: postRepositoryMock,
      resultMessageService: resultMessageServiceMock,
    );
  });

  group("PostViewModel", () {
    group("List", () {
      late List<PostDetailDto> postList;
      test("Listando todos os posts", () async {
        postList = (database['posts'] as List)
            .map((e) => PostDetailDto.fromMap(e as Map<String, dynamic>))
            .toList();

        when(
          () => postRepositoryMock.list(),
        ).thenAnswer((invocation) async => Success(postList));

        await postViewModel.list();

        expect(postViewModel.isLoading, false);
        expect(postViewModel.serverError, false);
        expect(postViewModel.postList, equals(postList));
        expect(postViewModel.postList?.length, equals(4));
        expect(postViewModel.postListByFileType?.length, equals(null));
        expect(postViewModel.post, equals(null));

        verify(() => postRepositoryMock.list()).called(1);
      });
    });
    group("ListByFileType", () {
      late List<PostDetailDto> postListByFileType;
      test("Listando todos os posts do tipo 'TEXT'", () async {
        postListByFileType = (database['posts'] as List)
            .map((e) => PostDetailDto.fromMap(e as Map<String, dynamic>))
            .where((element) => element.postType == "TEXT")
            .toList();

        when(
          () => postRepositoryMock.listByFileType("TEXT"),
        ).thenAnswer((invocation) async => Success(postListByFileType));

        await postViewModel.listByFileType("TEXT");

        expect(postViewModel.isLoading, false);
        expect(postViewModel.serverError, false);
        expect(postViewModel.postListByFileType, equals(postListByFileType));
        expect(postViewModel.postListByFileType?.length, equals(1));
        expect(postViewModel.postList?.length, equals(null));
        expect(postViewModel.post, equals(null));

        verify(() => postRepositoryMock.listByFileType("TEXT")).called(1);
      });

      test("Listando todos os posts do tipo 'IMAGE'", () async {
        postListByFileType = (database['posts'] as List)
            .map((e) => PostDetailDto.fromMap(e as Map<String, dynamic>))
            .where((element) => element.postType == "IMAGE")
            .toList();

        when(
          () => postRepositoryMock.listByFileType("IMAGE"),
        ).thenAnswer((invocation) async => Success(postListByFileType));

        await postViewModel.listByFileType("IMAGE");

        expect(postViewModel.isLoading, false);
        expect(postViewModel.serverError, false);
        expect(postViewModel.postListByFileType, equals(postListByFileType));
        expect(postViewModel.postListByFileType?.length, equals(2));
        expect(postViewModel.postList?.length, equals(null));
        expect(postViewModel.post, equals(null));

        verify(() => postRepositoryMock.listByFileType("IMAGE")).called(1);
      });
      test("Listando todos os posts do tipo 'VIDEO'", () async {
        postListByFileType = (database['posts'] as List)
            .map((e) => PostDetailDto.fromMap(e as Map<String, dynamic>))
            .where((element) => element.postType == "VIDEO")
            .toList();

        when(
          () => postRepositoryMock.listByFileType("VIDEO"),
        ).thenAnswer((invocation) async => Success(postListByFileType));

        await postViewModel.listByFileType("VIDEO");

        expect(postViewModel.isLoading, false);
        expect(postViewModel.serverError, false);
        expect(postViewModel.postListByFileType, equals(postListByFileType));
        expect(postViewModel.postListByFileType?.length, equals(1));
        expect(postViewModel.postList?.length, equals(null));
        expect(postViewModel.post, equals(null));

        verify(() => postRepositoryMock.listByFileType("VIDEO")).called(1);
      });
    });
    group("Detalhes Corretos do Post", () {
      late PostDetailDto post;
      late String id;
      test("Listando todos os posts do tipo 'TEXT'", () async {
        id = "3e9ef2f9-c3e6-4d5b-8208-89d4907a89ec";
        post = PostDetailDto.fromMap((database["posts"] as List)[1]);

        when(
          () => postRepositoryMock.detail(any()),
        ).thenAnswer((invocation) async => Success(post));
        when(
          () => postRepositoryMock.detail(any()),
        ).thenAnswer((_) async => Success(post));

        await postViewModel.detail(id);

        expect(postViewModel.isLoading, false);
        expect(postViewModel.serverError, false);
        expect(postViewModel.post, equals(post));
        expect(postViewModel.post?.id, equals(id));
        expect(postViewModel.postListByFileType?.length, equals(null));
        expect(postViewModel.postList?.length, equals(null));

        verify(() => postRepositoryMock.detail(id)).called(1);
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

        (database['posts'] as List).add(postDetailDto.toMap());

        when(
          () => postRepositoryMock.register(postRegisterDto, any()),
        ).thenAnswer((invocation) async => Success(postDetailDto));
        when(
          () =>
              resultMessageServiceMock.showMessageSuccess(any(), any(), ),
        ).thenReturn(null);

        await postViewModel.register(postRegisterDto, null);

        expect(postViewModel.isLoading, false);
        expect(postViewModel.serverError, false);
        expect(postViewModel.post, equals(null));
        expect(postViewModel.postListByFileType?.length, equals(null));
        expect(postViewModel.postList?.length, equals(null));
        expect(
          (database['posts'] as List).any(
            (element) =>
                postDetailDto.id == element['id'] &&
                postDetailDto.title == element['title'] &&
                postDetailDto.description == element['description'],
          ),
          isTrue,
        );

        verify(
          () => postRepositoryMock.register(postRegisterDto, any()),
        ).called(1);
        verify(
          () =>
              resultMessageServiceMock.showMessageSuccess(any(), any(),),
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

        when(
          () => postRepositoryMock.update(id, postUpdateDto, any()),
        ).thenAnswer((invocation) async => Success(postDetailDto));
        when(
          () =>
              resultMessageServiceMock.showMessageSuccess(any(), any(), ),
        ).thenReturn(null);

        await postViewModel.update(id, postUpdateDto, null);

        expect(postViewModel.isLoading, false);
        expect(postViewModel.serverError, false);
        expect(postViewModel.post, equals(null));
        expect(postViewModel.postListByFileType?.length, equals(null));
        expect(postViewModel.postList?.length, equals(null));
        expect(postDetailDto.id, equals(id));
        expect(
          (database['posts'] as List).any(
            (element) =>
                postDetailDto.id == element['id'] &&
                postDetailDto.title == element['title'],
          ),
          isTrue,
        );

        verify(
          () => postRepositoryMock.update(id, postUpdateDto, any()),
        ).called(1);
        verify(
          () =>
              resultMessageServiceMock.showMessageSuccess(any(), any(),),
        ).called(1);
      });
    });
    group("Remove", () {
      late String id;

      test("Removendo um Post", () async {
        id = '6a2c451c-f4d9-48c7-9e29-a1ecbb809b03';
        (database['posts'] as List).removeWhere((post) => post['id'] == id);

        when(
          () => postRepositoryMock.remove(id),
        ).thenAnswer((invocation) async => Success(Unit));
        when(
          () =>
              resultMessageServiceMock.showMessageSuccess(any(), any(),),
        ).thenReturn(null);

        await postViewModel.remove(id);

        expect(postViewModel.isLoading, false);
        expect(postViewModel.serverError, false);
        expect(postViewModel.post, equals(null));
        expect(postViewModel.postListByFileType?.length, equals(null));
        expect(postViewModel.postList?.length, equals(null));
        expect(
          (database['posts'] as List).any((element) => id == element['id']),
          isFalse,
        );
        
        verify(() => postRepositoryMock.remove(id)).called(1);
        verify(
          () =>
              resultMessageServiceMock.showMessageSuccess(any(), any(), ),
        ).called(1);
      });
    });
  });
}
