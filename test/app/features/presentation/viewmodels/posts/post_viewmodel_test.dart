import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pulse_post/app/core/services/messages/result_message_service.dart';
import 'package:pulse_post/app/core/usecase/usecase.dart';
import 'package:pulse_post/app/features/domain/entities/post_entity.dart';
import 'package:pulse_post/app/features/domain/entities/user_sumary_entity.dart';
import 'package:pulse_post/app/features/domain/params/posts/post_register_param.dart';
import 'package:pulse_post/app/features/domain/params/posts/post_update_param.dart';
import 'package:pulse_post/app/features/domain/usecases/posts/post_usecase_detail.dart';
import 'package:pulse_post/app/features/domain/usecases/posts/post_usecase_list.dart';
import 'package:pulse_post/app/features/domain/usecases/posts/post_usecase_list_by_file_type.dart';
import 'package:pulse_post/app/features/domain/usecases/posts/post_usecase_register.dart';
import 'package:pulse_post/app/features/domain/usecases/posts/post_usecase_remove.dart';
import 'package:pulse_post/app/features/domain/usecases/posts/post_usecase_update.dart';
import 'package:pulse_post/app/features/presentation/viewmodels/posts/post_viewmodel.dart';
import 'package:result_dart/result_dart.dart';

class ResultMessageServiceMock extends Mock implements ResultMessageService {}

class PostUsecaseListMock extends Mock implements PostUsecaseList {}

class PostUsecaseListByFileTypeMock extends Mock
    implements PostUsecaseListByFileType {}

class PostUsecaseDetailMock extends Mock implements PostUsecaseDetail {}

class PostUsecaseRegisterMock extends Mock implements PostUsecaseRegister {}

class PostUsecaseUpdateMock extends Mock implements PostUsecaseUpdate {}

class PostUsecaseRemoveMock extends Mock implements PostUsecaseRemove {}

void main() {
  late ResultMessageServiceMock resultMessageServiceMock;
  late PostUsecaseListMock postUsecaseListMock;
  late PostUsecaseListByFileTypeMock postUsecaseListByFileTypeMock;
  late PostUsecaseDetailMock postUsecaseDetailMock;
  late PostUsecaseRegisterMock postUsecaseRegisterMock;
  late PostUsecaseUpdateMock postUsecaseUpdateMock;
  late PostUsecaseRemoveMock postUsecaseRemoveMock;
  late PostViewmodel postViewmodel;

  late List<PostEntity> database = [
    PostEntity(
      id: "1",
      title: "title 01",
      description: "description 01",
      createdAt: "10/10/2025",
      postType: "TEXT",
      user: UserSummaryEntity(id: "1", name: "Lázaro"),
    ),
    PostEntity(
      id: "2",
      title: "title 02",
      description: "description 02",
      createdAt: "10/10/2025",
      postType: "TEXT",
      user: UserSummaryEntity(id: "1", name: "Lázaro"),
    ),
    PostEntity(
      id: "3",
      title: "title 03",
      description: "description 03",
      createdAt: "10/10/2025",
      postType: "IMAGE",
      file: "image.png",
      user: UserSummaryEntity(id: "1", name: "Lázaro"),
    ),
    PostEntity(
      id: "4",
      title: "title 04",
      description: "description 04",
      createdAt: "10/10/2025",
      postType: "VIDEO",
      file: "video.mp4",
      user: UserSummaryEntity(id: "2", name: "Luis"),
    ),
  ];

  setUp(() {
    resultMessageServiceMock = ResultMessageServiceMock();
    postUsecaseListMock = PostUsecaseListMock();
    postUsecaseListByFileTypeMock = PostUsecaseListByFileTypeMock();
    postUsecaseDetailMock = PostUsecaseDetailMock();
    postUsecaseRegisterMock = PostUsecaseRegisterMock();
    postUsecaseUpdateMock = PostUsecaseUpdateMock();
    postUsecaseRemoveMock = PostUsecaseRemoveMock();

    resultMessageServiceMock = ResultMessageServiceMock();
    postViewmodel = PostViewmodel(
      postUsecaseList: postUsecaseListMock,
      postUsecaseListByFileType: postUsecaseListByFileTypeMock,
      postUsecaseDetail: postUsecaseDetailMock,
      postUsecaseRegister: postUsecaseRegisterMock,
      postUsecaseUpdate: postUsecaseUpdateMock,
      postUsecaseRemove: postUsecaseRemoveMock,
      resultMessageService: resultMessageServiceMock,
    );
  });

  group("PostViewmodel", () {
    group("List", () {
      test("Deve listar posts com sucesso", () async {
        when(
          () => postUsecaseListMock(NoParams()),
        ).thenAnswer((_) async => Success(database));

        await postViewmodel.list();

        expect(postViewmodel.isLoading, false);
        expect(postViewmodel.serverError, false);
        expect(postViewmodel.postList, isA<List<PostEntity>>());
        expect(postViewmodel.postList?.length, 4);
        expect(postViewmodel.postList, database);

        verify(() => postUsecaseListMock(NoParams())).called(1);
      });

      test("Deve retornar erro ao listar posts", () async {
        when(
          () => postUsecaseListMock(NoParams()),
        ).thenAnswer((_) async => Failure(Exception()));

        await postViewmodel.list();

        expect(postViewmodel.isLoading, false);
        expect(postViewmodel.serverError, true);
        expect(postViewmodel.postList, null);

        verify(() => postUsecaseListMock(NoParams())).called(1);
        verify(
          () => resultMessageServiceMock.showMessageError(any()),
        ).called(1);
      });
    });

    group("ListByFileType", () {
      test("Deve listar posts por tipo 'TEXT' com sucesso", () async {
        final resultList = database.where((e) => e.postType == "TEXT").toList();

        when(
          () => postUsecaseListByFileTypeMock("TEXT"),
        ).thenAnswer((_) async => Success(resultList));

        await postViewmodel.listByFileType("TEXT");

        expect(postViewmodel.serverError, false);
        expect(postViewmodel.postListByFileType, isA<List<PostEntity>>());
        expect(postViewmodel.postListByFileType?.length, 2);
        expect(postViewmodel.postListByFileType, resultList);

        verify(() => postUsecaseListByFileTypeMock("TEXT")).called(1);
      });

      test("Deve retornar erro ao listar por tipo 'TEXT'", () async {
        when(
          () => postUsecaseListByFileTypeMock(any()),
        ).thenAnswer((_) async => Failure(Exception()));

        await postViewmodel.listByFileType("TEXT");

        expect(postViewmodel.serverError, true);

        verify(() => postUsecaseListByFileTypeMock("TEXT")).called(1);
        verify(
          () => resultMessageServiceMock.showMessageError(any()),
        ).called(1);
      });

      test("Deve listar posts por tipo 'IMAGE' com sucesso", () async {
        final resultList = database
            .where((e) => e.postType == "IMAGE")
            .toList();

        when(
          () => postUsecaseListByFileTypeMock("IMAGE"),
        ).thenAnswer((_) async => Success(resultList));

        await postViewmodel.listByFileType("IMAGE");

        expect(postViewmodel.serverError, false);
        expect(postViewmodel.postListByFileType, isA<List<PostEntity>>());
        expect(postViewmodel.postListByFileType?.length, 1);
        expect(postViewmodel.postListByFileType, resultList);

        verify(() => postUsecaseListByFileTypeMock("IMAGE")).called(1);
      });

      test("Deve retornar erro ao listar por tipo 'IMAGE'", () async {
        when(
          () => postUsecaseListByFileTypeMock(any()),
        ).thenAnswer((_) async => Failure(Exception()));

        await postViewmodel.listByFileType("IMAGE");

        expect(postViewmodel.serverError, true);

        verify(() => postUsecaseListByFileTypeMock("IMAGE")).called(1);
        verify(
          () => resultMessageServiceMock.showMessageError(any()),
        ).called(1);
      });

      test("Deve listar posts por tipo 'VIDEO' com sucesso", () async {
        final resultList = database
            .where((e) => e.postType == "IMAGE")
            .toList();

        when(
          () => postUsecaseListByFileTypeMock("VIDEO"),
        ).thenAnswer((_) async => Success(resultList));

        await postViewmodel.listByFileType("VIDEO");

        expect(postViewmodel.serverError, false);
        expect(postViewmodel.postListByFileType, isA<List<PostEntity>>());
        expect(postViewmodel.postListByFileType?.length, 1);
        expect(postViewmodel.postListByFileType, resultList);

        verify(() => postUsecaseListByFileTypeMock("VIDEO")).called(1);
      });

      test("Deve retornar erro ao listar por tipo 'VIDEO'", () async {
        when(
          () => postUsecaseListByFileTypeMock(any()),
        ).thenAnswer((_) async => Failure(Exception()));

        await postViewmodel.listByFileType("VIDEO");

        expect(postViewmodel.serverError, true);

        verify(() => postUsecaseListByFileTypeMock("VIDEO")).called(1);
        verify(
          () => resultMessageServiceMock.showMessageError(any()),
        ).called(1);
      });
    });

    group("Detail", () {
      test("Deve buscar detalhe com sucesso", () async {
        final post = database.first;

        when(
          () => postUsecaseDetailMock(post.id),
        ).thenAnswer((_) async => Success(post));

        await postViewmodel.detail(post.id);

        expect(postViewmodel.serverError, false);
        expect(postViewmodel.post, post);
        expect(postViewmodel.post?.id, "1");
        expect(postViewmodel.post?.title, "title 01");
        expect(postViewmodel.post, isA<PostEntity>());

        verify(() => postUsecaseDetailMock(post.id)).called(1);
      });

      test("Deve retornar erro ao buscar detalhe", () async {
        when(
          () => postUsecaseDetailMock(any()),
        ).thenAnswer((_) async => Failure(Exception()));

        await postViewmodel.detail("1");

        expect(postViewmodel.serverError, true);

        verify(
          () => resultMessageServiceMock.showMessageError(any()),
        ).called(1);
      });
    });

    group("Register", () {
      test("Deve registrar post com sucesso", () async {
        final param = PostRegisterParam(title: "Novo", description: "Desc");
        final output = PostEntity(
          id: "5",
          title: param.title,
          description: param.description,
          postType: "TEXT",
          createdAt: "10/10/2025",
          user: UserSummaryEntity(id: "2", name: "Luis"),
        );
        when(
          () => postUsecaseRegisterMock(param),
        ).thenAnswer((_) async => Success(output));

        when(
          () => resultMessageServiceMock.showMessageSuccess(any(), any()),
        ).thenReturn(null);

        database.add(output);

        await postViewmodel.register(param);

        expect(postViewmodel.serverError, false);
        expect(database.any((element) => element.id == "5"), isTrue);
        expect(database.any((element) => element == output), isTrue);

        verify(() => postUsecaseRegisterMock(param)).called(1);
        verify(
          () => resultMessageServiceMock.showMessageSuccess(any(), any()),
        ).called(1);
      });

      test("Deve retornar erro ao registrar", () async {
        final param = PostRegisterParam(title: "Novo", description: "Desc");

        when(
          () => postUsecaseRegisterMock(param),
        ).thenAnswer((_) async => Failure(Exception()));

        await postViewmodel.register(param);

        expect(postViewmodel.serverError, true);

        verify(() => postUsecaseRegisterMock(param)).called(1);
        verify(
          () => resultMessageServiceMock.showMessageError(any()),
        ).called(1);
      });
    });

    group("Update", () {
      test("Deve atualizar post com sucesso", () async {
        final param = PostUpdateParam(id: "3", title: "Atualizado");
        final index = database.indexWhere((element) => element.id == param.id);
        final oldEntity = database[index];

        final output = PostEntity(
          id: oldEntity.id,
          title: param.title ?? oldEntity.title,
          description: oldEntity.description,
          postType: oldEntity.postType,
          createdAt: oldEntity.createdAt,
          user: oldEntity.user,
          file: oldEntity.file,
          updateAt: "11/10/2025",
        );

        database[index] = output;

        when(
          () => postUsecaseUpdateMock(param),
        ).thenAnswer((_) async => Success(output));

        when(
          () => resultMessageServiceMock.showMessageSuccess(any(), any()),
        ).thenReturn(null);

        await postViewmodel.update(param);

        expect(postViewmodel.serverError, false);
        expect(database[index], output);
        expect(database[index].id, "3");
        expect(database[index].title, "Atualizado");
        expect(database.any((element) => element == output), isTrue);

        verify(() => postUsecaseUpdateMock(param)).called(1);
        verify(
          () => resultMessageServiceMock.showMessageSuccess(any(), any()),
        ).called(1);
      });

      test("Deve retornar erro ao atualizar", () async {
        final param = PostUpdateParam(id: "1", title: "Atualizado");

        when(
          () => postUsecaseUpdateMock(param),
        ).thenAnswer((_) async => Failure(Exception()));

        await postViewmodel.update(param);

        expect(postViewmodel.serverError, true);

        verify(() => postUsecaseUpdateMock(param)).called(1);
        verify(
          () => resultMessageServiceMock.showMessageError(any()),
        ).called(1);
      });
    });

    group("Remove", () {
      test("Deve remover post com sucesso", () async {
        final String id = "1";
        final index = database.indexWhere((element) => element.id == id);

        when(
          () => postUsecaseRemoveMock(id),
        ).thenAnswer((_) async => Success(unit));

        when(
          () => resultMessageServiceMock.showMessageSuccess(any(), any()),
        ).thenReturn(null);

        await postViewmodel.remove(id);

        database.removeAt(index);

        expect(postViewmodel.serverError, false);
        expect(database.any((element) => element.id == id,), false);

        verify(() => postUsecaseRemoveMock(id)).called(1);
        verify(
          () => resultMessageServiceMock.showMessageSuccess(any(), any()),
        ).called(1);
      });

      test("Deve retornar erro ao remover", () async {
        final String id = "1";

        when(
          () => postUsecaseRemoveMock(id),
        ).thenAnswer((_) async => Failure(Exception()));

        await postViewmodel.remove(id);

        expect(postViewmodel.serverError, true);
        verify(() => postUsecaseRemoveMock(id)).called(1);

        verify(
          () => resultMessageServiceMock.showMessageError(any()),
        ).called(1);
      });
    });
  });
}
