import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:amago/app/core/exceptions/rest_exception.dart';
import 'package:amago/app/features/data/datasources/post/post_datasource.dart';
import 'package:amago/app/features/data/models/post_model.dart';
import 'package:amago/app/features/data/models/user_summary_model.dart';
import 'package:amago/app/features/data/repositories/post_repository_impl.dart';
import 'package:amago/app/features/domain/entities/post_entity.dart';
import 'package:amago/app/features/domain/params/posts/post_register_param.dart';
import 'package:amago/app/features/domain/params/posts/post_update_param.dart';
import 'package:amago/app/features/domain/repositories/post_repository.dart';

class PostDatasourceMock extends Mock implements PostDatasource {}

void main() {
  late PostDatasource datasourceMock;
  late PostRepository repository;

  setUp(() {
    datasourceMock = PostDatasourceMock();
    repository = PostRepositoryImpl(datasource: datasourceMock);
  });

  group("PostRepositoryImpl", () {
    group("detail", () {
      test('deve retornar Success<PostEntity>', () async {
        final output = PostModel(
          id: '1',
          title: 'Título',
          description: 'Desc',
          postType: 'TEXT',
          createdAt: '2025-01-01',
          user: UserSummaryModel(id: '1', name: 'Lázaro'),
        );

        when(() => datasourceMock.detail('1')).thenAnswer((_) async => output);

        final result = await repository.detail('1');

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), isA<PostEntity>());
        expect(result.getOrNull(), output);

        verify(() => datasourceMock.detail('1')).called(1);
      });

      test('deve retornar Failure ao lançar DioException', () async {
        when(() => datasourceMock.detail('1')).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 500,
            ),
          ),
        );

        final result = await repository.detail('1');
        final error = result.exceptionOrNull() as RestException;

        expect(result.isError(), isTrue);
        expect(result.exceptionOrNull(), isA<RestException>());
        expect(error.statusCode, 500);

        verify(() => datasourceMock.detail('1')).called(1);
      });
    });

    group("list", () {
      test('deve retornar Success<List<PostEntity>>', () async {
        final output = [
          PostModel(
            id: '1',
            title: 'Título 1',
            description: 'Desc',
            postType: 'TEXT',
            createdAt: '2025-01-01',
            user: UserSummaryModel(id: '1', name: 'Lázaro'),
          ),
          PostModel(
            id: '2',
            title: 'Título 2',
            description: 'Desc',
            postType: 'TEXT',
            createdAt: '2025-01-01',
            user: UserSummaryModel(id: '1', name: 'Lázaro'),
          ),
        ];

        when(() => datasourceMock.list()).thenAnswer((_) async => output);

        final result = await repository.list();

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), isA<List<PostEntity>>());
        expect(result.getOrNull(), output);
        expect(result.getOrNull()?.length, 2);

        verify(() => datasourceMock.list()).called(1);
      });

      test('deve retornar Failure ao lançar DioException', () async {
        when(() => datasourceMock.list()).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 500,
            ),
          ),
        );

        final result = await repository.list();
        final error = result.exceptionOrNull() as RestException;

        expect(result.isError(), isTrue);
        expect(result.exceptionOrNull(), isA<RestException>());
        expect(error.statusCode, 500);

        verify(() => datasourceMock.list()).called(1);
      });
    });

    group("listByFileType", () {
      test('deve retornar Success<List<PostEntity>>', () async {
        final output = [
          PostModel(
            id: '1',
            title: 'texto',
            description: 'Desc',
            postType: 'TEXT',
            createdAt: '2025-01-01',
            user: UserSummaryModel(id: '1', name: 'Lázaro'),
          ),
        ];

        when(
          () => datasourceMock.listByFileType('TEXT'),
        ).thenAnswer((_) async => output);

        final result = await repository.listByFileType('TEXT');
        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), isA<List<PostEntity>>());
        expect(result.getOrNull(), output);
        expect(result.getOrNull()?.length, 1);
        verify(() => datasourceMock.listByFileType('TEXT')).called(1);
      });

      test('deve retornar Failure ao lançar DioException', () async {
        when(() => datasourceMock.listByFileType('TEXT')).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 500,
            ),
          ),
        );

        final result = await repository.listByFileType('TEXT');
        final error = result.exceptionOrNull() as RestException;

        expect(result.isError(), isTrue);
        expect(result.exceptionOrNull(), isA<RestException>());
        expect(error.statusCode, 500);

        verify(() => datasourceMock.listByFileType('TEXT')).called(1);
      });

      test('deve retornar Success<List<PostEntity>>', () async {
        final output = [
          PostModel(
            id: '1',
            title: 'Imagem',
            description: 'Desc',
            postType: 'IMAGE',
            file: 'img.png',
            createdAt: '2025-01-01',
            user: UserSummaryModel(id: '1', name: 'Lázaro'),
          ),
        ];

        when(
          () => datasourceMock.listByFileType('IMAGE'),
        ).thenAnswer((_) async => output);

        final result = await repository.listByFileType('IMAGE');
        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), isA<List<PostEntity>>());
        expect(result.getOrNull(), output);
        expect(result.getOrNull()?.length, 1);
        verify(() => datasourceMock.listByFileType('IMAGE')).called(1);
      });

      test('deve retornar Failure ao lançar DioException', () async {
        when(() => datasourceMock.listByFileType('IMAGE')).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 500,
            ),
          ),
        );

        final result = await repository.listByFileType('IMAGE');
        final error = result.exceptionOrNull() as RestException;

        expect(result.isError(), isTrue);
        expect(result.exceptionOrNull(), isA<RestException>());
        expect(error.statusCode, 500);

        verify(() => datasourceMock.listByFileType('IMAGE')).called(1);
      });

      test('deve retornar Success<List<PostEntity>>', () async {
        final output = [
          PostModel(
            id: '1',
            title: 'Vídeo',
            description: 'Desc',
            postType: 'VIDEO',
            file: 'img.png',
            createdAt: '2025-01-01',
            user: UserSummaryModel(id: '1', name: 'Lázaro'),
          ),
        ];

        when(
          () => datasourceMock.listByFileType('VIDEO'),
        ).thenAnswer((_) async => output);

        final result = await repository.listByFileType('VIDEO');
        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), isA<List<PostEntity>>());
        expect(result.getOrNull(), output);
        expect(result.getOrNull()?.length, 1);
        verify(() => datasourceMock.listByFileType('VIDEO')).called(1);
      });

      test('deve retornar Failure ao lançar DioException', () async {
        when(() => datasourceMock.listByFileType('VIDEO')).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 500,
            ),
          ),
        );

        final result = await repository.listByFileType('VIDEO');
        final error = result.exceptionOrNull() as RestException;

        expect(result.isError(), isTrue);
        expect(result.exceptionOrNull(), isA<RestException>());
        expect(error.statusCode, 500);

        verify(() => datasourceMock.listByFileType('VIDEO')).called(1);
      });
    });

    group("register", () {
      late PostRegisterParam input;

      test('deve retornar Success<PostEntity>', () async {
        input = PostRegisterParam(title: 'Título', description: 'Desc');

        final output = PostModel(
          id: '1',
          title: 'Título',
          description: 'Desc',
          postType: 'TEXT',
          createdAt: '2025-01-01',
          user: UserSummaryModel(id: '1', name: 'Lázaro'),
        );

        when(
          () => datasourceMock.register(input),
        ).thenAnswer((_) async => output);

        final result = await repository.register(input);

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), isA<PostEntity>());
        expect(result.getOrNull(), output);

        verify(() => datasourceMock.register(input)).called(1);
      });

      test('deve retornar Failure ao lançar DioException', () async {
        input = PostRegisterParam(title: 'Título', description: 'Desc');

        when(() => datasourceMock.register(input)).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 500,
            ),
          ),
        );

        final result = await repository.register(input);
        final error = result.exceptionOrNull() as RestException;

        expect(result.isError(), isTrue);
        expect(result.exceptionOrNull(), isA<RestException>());
        expect(error.statusCode, 500);

        verify(() => datasourceMock.register(input)).called(1);
      });
    });

    group("update", () {
      late PostUpdateParam input;

      test('deve retornar Success<PostEntity>', () async {
        input = PostUpdateParam(id: '1', title: 'Novo', description: 'Desc');

        final output = PostModel(
          id: '1',
          title: 'Novo',
          description: 'Desc',
          postType: 'TEXT',
          createdAt: '2025-01-01',
          user: UserSummaryModel(id: '1', name: 'Lázaro'),
        );

        when(
          () => datasourceMock.update(input),
        ).thenAnswer((_) async => output);

        final result = await repository.update(input);

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), isA<PostEntity>());
        expect(result.getOrNull(), output);

        verify(() => datasourceMock.update(input)).called(1);
      });

      test('deve retornar Failure ao lançar DioException', () async {
        input = PostUpdateParam(id: '1', title: 'Novo', description: 'Desc');

        when(() => datasourceMock.update(input)).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 500,
            ),
          ),
        );

        final result = await repository.update(input);
        final error = result.exceptionOrNull() as RestException;

        expect(result.isError(), isTrue);
        expect(result.exceptionOrNull(), isA<RestException>());
        expect(error.statusCode, 500);

        verify(() => datasourceMock.update(input)).called(1);
      });
    });

    group("remove", () {
      test('deve retornar Success<Object>', () async {
        when(
          () => datasourceMock.remove('1'),
        ).thenAnswer((_) async => Object());

        final result = await repository.remove('1');

        expect(result.isSuccess(), isTrue);

        verify(() => datasourceMock.remove('1')).called(1);
      });

      test('deve retornar Failure ao lançar DioException', () async {
        when(() => datasourceMock.remove('1')).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 500,
            ),
          ),
        );

        final result = await repository.remove('1');
        final error = result.exceptionOrNull() as RestException;

        expect(result.isError(), isTrue);
        expect(result.exceptionOrNull(), isA<RestException>());
        expect(error.statusCode, 500);

        verify(() => datasourceMock.remove('1')).called(1);
      });
    });
  });
}
