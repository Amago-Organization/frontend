import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:amago/app/core/services/client/client_service.dart';
import 'package:amago/app/features/data/datasources/post/post_datasource.dart';
import 'package:amago/app/features/data/datasources/post/post_datasource_impl.dart';
import 'package:amago/app/features/data/models/post_model.dart';
import 'package:amago/app/features/domain/params/posts/post_register_param.dart';
import 'package:amago/app/features/domain/params/posts/post_update_param.dart';

class ClientServiceMock extends Mock implements ClientService {}

class FormDataFake extends Fake implements FormData {}

void main() {
  late ClientServiceMock clientServiceMock;
  late PostDatasource datasource;

  setUpAll(() {
    registerFallbackValue(FormDataFake());
  });

  setUp(() {
    clientServiceMock = ClientServiceMock();
    datasource = PostDatasourceImpl(clientService: clientServiceMock);
  });

  group("PostDatasourceImpl", () {
    group("Detail", () {
      late PostModel output;
      late Map<String, dynamic> data;
      test('deve retornar PostModel ao buscar detalhe com sucesso', () async {
        data = {
          'id': '1',
          'title': 'Título',
          'description': 'Desc',
          'postType': 'TEXT',
          'createdAt': '2025-01-01',
          'user': {'id': '10', 'name': 'Lázaro', 'image': 'img.png'},
        };

        output = PostModel.fromMap(data);

        when(() => clientServiceMock.get(any(), requiresAuth: true)).thenAnswer(
          (_) async => Response(requestOptions: RequestOptions(), data: data),
        );

        final result = await datasource.detail('1');

        expect(result, isA<PostModel>());
        expect(result, output);
        expect(result.id, '1');
        expect(result.title, 'Título');
        expect(result.description, 'Desc');
        expect(result.createdAt, '2025-01-01');
        expect(result.postType, 'TEXT');
        expect(result.file, null);
        expect(result.updateAt, null);
        expect(result.user.id, '10');
        expect(result.user.name, 'Lázaro');
        expect(result.user.image, 'img.png');

        verify(
          () => clientServiceMock.get(any(), requiresAuth: true),
        ).called(1);
      });
      test('deve lançar erro ao falhar no detail', () async {
        when(
          () => clientServiceMock.get(any(), requiresAuth: true),
        ).thenThrow(Exception());

        expect(() => datasource.detail('1'), throwsException);

        verify(
          () => clientServiceMock.get(any(), requiresAuth: true),
        ).called(1);
      });
    });

    group("List", () {
      late List<PostModel> output;
      late Map<String, dynamic> data;
      late List<dynamic> list;
      test('deve retornar lista de posts com sucesso', () async {
        data = {
          'posts': [
            {
              'id': '1',
              'title': 'Título 1',
              'description': 'Descrição',
              'postType': 'TEXT',
              'createdAt': '2025-01-01',
              'user': {'id': '10', 'name': 'Lázaro', 'image': 'img.png'},
            },
            {
              'id': '2',
              'title': 'Título 2',
              'description': 'Descrição',
              'postType': 'TEXT',
              'createdAt': '2025-01-01',
              'user': {'id': '10', 'name': 'Lázaro', 'image': 'img.png'},
            },
          ],
        };

        list = data['posts'];
        output = list
            .map((item) => PostModel.fromMap(item as Map<String, dynamic>))
            .toList();

        when(() => clientServiceMock.get(any(), requiresAuth: true)).thenAnswer(
          (_) async => Response(requestOptions: RequestOptions(), data: data),
        );

        final result = await datasource.list();

        expect(result, isA<List<PostModel>>());
        expect(result, output);
        expect(result.length, 2);

        verify(
          () => clientServiceMock.get(any(), requiresAuth: true),
        ).called(1);
      });

      test('deve lançar erro ao falhar no list', () async {
        when(
          () => clientServiceMock.get(any(), requiresAuth: true),
        ).thenThrow(Exception());

        expect(() => datasource.list(), throwsException);
        verify(
          () => clientServiceMock.get(any(), requiresAuth: true),
        ).called(1);
      });
    });

    group("ListByFileType", () {
      late List<PostModel> output;
      late Map<String, dynamic> data;
      late List<dynamic> list;
      test(
        'deve retornar lista de posts por tipo "TEXT" com sucesso',
        () async {
          data = {
            'posts': [
              {
                'id': '1',
                'title': 'Título 1',
                'description': 'Descrição',
                'postType': 'TEXT',
                'createdAt': '2025-01-01',
                'user': {'id': '10', 'name': 'Lázaro', 'image': 'img.png'},
              },
              {
                'id': '2',
                'title': 'Título 2',
                'description': 'Descrição',
                'postType': 'TEXT',
                'createdAt': '2025-01-01',
                'user': {'id': '10', 'name': 'Lázaro', 'image': 'img.png'},
              },
            ],
          };

          list = data['posts'];
          output = list
              .map((item) => PostModel.fromMap(item as Map<String, dynamic>))
              .toList();

          when(
            () => clientServiceMock.get(any(), requiresAuth: true),
          ).thenAnswer(
            (_) async => Response(requestOptions: RequestOptions(), data: data),
          );

          final result = await datasource.listByFileType('TEXT');

          expect(result, isA<List<PostModel>>());
          expect(result, output);
          expect(result.every((element) => element.postType == 'TEXT'), isTrue);
          expect(result.length, 2);

          verify(
            () => clientServiceMock.get(any(), requiresAuth: true),
          ).called(1);
        },
      );

      test('deve lançar erro ao falhar no list de posts tipo "TEXT"', () async {
        when(
          () => clientServiceMock.get(any(), requiresAuth: true),
        ).thenThrow(Exception());

        expect(() => datasource.listByFileType('TEXT'), throwsException);
        verify(
          () => clientServiceMock.get(any(), requiresAuth: true),
        ).called(1);
      });
      test(
        'deve retornar lista de posts por tipo "IMAGE" com sucesso',
        () async {
          data = {
            'posts': [
              {
                'id': '3',
                'title': 'Título 3',
                'description': 'Desc',
                'postType': 'IMAGE',
                'file': 'image.png',
                'createdAt': '2025-01-01',
                'user': {'id': '10', 'name': 'Lázaro', 'image': 'img.png'},
              },
            ],
          };

          list = data['posts'];
          output = list
              .map((item) => PostModel.fromMap(item as Map<String, dynamic>))
              .toList();

          when(
            () => clientServiceMock.get(any(), requiresAuth: true),
          ).thenAnswer(
            (_) async => Response(requestOptions: RequestOptions(), data: data),
          );

          final result = await datasource.listByFileType('IMAGE');

          expect(result, isA<List<PostModel>>());
          expect(result, output);
          expect(
            result.every((element) => element.postType == 'IMAGE'),
            isTrue,
          );
          expect(result.every((element) => element.file != null), isTrue);
          expect(result.length, 1);

          verify(
            () => clientServiceMock.get(any(), requiresAuth: true),
          ).called(1);
        },
      );

      test(
        'deve lançar erro ao falhar no list de posts tipo "IMAGE"',
        () async {
          when(
            () => clientServiceMock.get(any(), requiresAuth: true),
          ).thenThrow(Exception());

          expect(() => datasource.listByFileType('IMAGE'), throwsException);
          verify(
            () => clientServiceMock.get(any(), requiresAuth: true),
          ).called(1);
        },
      );

      test(
        'deve retornar lista de posts por tipo "VIDEO" com sucesso',
        () async {
          data = {
            'posts': [
              {
                'id': '4',
                'title': 'Título 4',
                'description': 'Desc',
                'postType': 'VIDEO',
                'file': 'video.mp4',
                'createdAt': '2025-01-01',
                'user': {'id': '10', 'name': 'Lázaro', 'image': 'img.png'},
              },
            ],
          };

          list = data['posts'];
          output = list
              .map((item) => PostModel.fromMap(item as Map<String, dynamic>))
              .toList();

          when(
            () => clientServiceMock.get(any(), requiresAuth: true),
          ).thenAnswer(
            (_) async => Response(requestOptions: RequestOptions(), data: data),
          );

          final result = await datasource.listByFileType('VIDEO');

          expect(result, isA<List<PostModel>>());
          expect(result, output);
          expect(
            result.every((element) => element.postType == 'VIDEO'),
            isTrue,
          );
          expect(result.every((element) => element.file != null), isTrue);
          expect(result.length, 1);

          verify(
            () => clientServiceMock.get(any(), requiresAuth: true),
          ).called(1);
        },
      );

      test(
        'deve lançar erro ao falhar no list de posts tipo "VIDEO"',
        () async {
          when(
            () => clientServiceMock.get(any(), requiresAuth: true),
          ).thenThrow(Exception());

          expect(() => datasource.listByFileType('VIDEO'), throwsException);
          verify(
            () => clientServiceMock.get(any(), requiresAuth: true),
          ).called(1);
        },
      );
    });

    group("Register", () {
      late PostRegisterParam input;
      late Map<String, dynamic> data;
      test('deve registrar post com sucesso', () async {
        input = PostRegisterParam(title: 'Título', description: 'Desc');

        data = {
          'id': '1',
          'title': 'Título',
          'description': 'Desc',
          'postType': 'TEXT',
          'createdAt': '2025-01-01',
          'user': {'id': '10', 'name': 'Lázaro', 'image': 'img.png'},
        };

        when(
          () => clientServiceMock.post(
            any(),
            any(),
            requiresAuth: true,
            contentType: 'multipart/form-data',
          ),
        ).thenAnswer(
          (_) async => Response(requestOptions: RequestOptions(), data: data),
        );

        final result = await datasource.register(input);

        expect(result, isA<PostModel>());
        expect(result, PostModel.fromMap(data));
        expect(result.title, 'Título');
        expect(result.description, 'Desc');
        verify(
          () => clientServiceMock.post(
            any(),
            any(),
            requiresAuth: true,
            contentType: 'multipart/form-data',
          ),
        ).called(1);
      });

      test('deve lançar erro ao falhar no register', () async {
        input = PostRegisterParam(title: 'Título', description: 'Desc');

        when(
          () => clientServiceMock.post(
            any(),
            any(),
            requiresAuth: true,
            contentType: 'multipart/form-data',
          ),
        ).thenThrow(Exception());

        expect(() => datasource.register(input), throwsException);

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
      late PostUpdateParam input;
      late Map<String, dynamic> data;

      test('deve atualizar post com sucesso', () async {
        input = PostUpdateParam(
          id: '1',
          title: 'Novo Título',
          description: 'Nova Desc',
        );

        data = {
          'id': '1',
          'title': 'Novo Título',
          'description': 'Desc',
          'postType': 'TEXT',
          'createdAt': '2025-01-01',
          'user': {'id': '10', 'name': 'Lázaro', 'image': 'img.png'},
        };

        when(
          () => clientServiceMock.patch(
            any(),
            any(),
            requiresAuth: true,
            contentType: 'multipart/form-data',
          ),
        ).thenAnswer(
          (_) async => Response(requestOptions: RequestOptions(), data: data),
        );

        final result = await datasource.update(input);

        expect(result, isA<PostModel>());
        expect(result, PostModel.fromMap(data));
        expect(result.title, 'Novo Título');

        verify(
          () => clientServiceMock.patch(
            any(),
            any(),
            requiresAuth: true,
            contentType: 'multipart/form-data',
          ),
        ).called(1);
      });

      test('deve lançar erro ao falhar no update', () async {
        input = PostUpdateParam(id: '1', title: 'Novo Título');

        when(
          () => clientServiceMock.patch(
            any(),
            any(),
            requiresAuth: true,
            contentType: 'multipart/form-data',
          ),
        ).thenThrow(Exception());

        expect(() => datasource.update(input), throwsException);

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
      test('deve remover post com sucesso', () async {
        when(
          () => clientServiceMock.delete(any(), requiresAuth: true),
        ).thenAnswer(
          (_) async => Response(requestOptions: RequestOptions(), data: {}),
        );

        final result = await datasource.remove('1');

        expect(result, isA<Object>());
        verify(
          () => clientServiceMock.delete(any(), requiresAuth: true),
        ).called(1);
      });

      test('deve lançar erro ao falhar no remove', () async {
        when(
          () => clientServiceMock.delete(any(), requiresAuth: true),
        ).thenThrow(Exception());

        expect(() => datasource.remove('1'), throwsException);
        verify(
          () => clientServiceMock.delete(any(), requiresAuth: true),
        ).called(1);
      });
    });
  });
}
