import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:amago/app/core/exceptions/rest_exception.dart';
import 'package:amago/app/features/data/datasources/user/user_datasource.dart';
import 'package:amago/app/features/data/models/user_model.dart';
import 'package:amago/app/features/data/repositories/user_repository_impl.dart';
import 'package:amago/app/features/domain/entities/user_entity.dart';
import 'package:amago/app/features/domain/params/users/user_login_param.dart';
import 'package:amago/app/features/domain/params/users/user_register_param.dart';
import 'package:amago/app/features/domain/params/users/user_update_param.dart';
import 'package:amago/app/features/domain/repositories/user_repository.dart';

class UserDatasourceMock extends Mock implements UserDatasource {}

void main() {
  late UserDatasource datasourceMock;
  late UserRepository repository;

  setUp(() {
    datasourceMock = UserDatasourceMock();
    repository = UserRepositoryImpl(datasource: datasourceMock);
  });
  group("UserRepositoryImpl", () {
    group("detail", () {
      test('deve retornar Success<UserEntity>', () async {
        final user = UserModel(
          id: '1',
          name: 'Lázaro',
          email: 'email@test.com',
          image: null,
          createdAt: '10/10/2025',
        );

        when(() => datasourceMock.detail()).thenAnswer((_) async => user);

        final result = await repository.detail();

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), isA<UserEntity>());
        expect(result.getOrNull(), user);

        verify(() => datasourceMock.detail()).called(1);
      });

      test('deve retornar Failure ao lançar DioException', () async {
        when(() => datasourceMock.detail()).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 500,
            ),
          ),
        );

        final result = await repository.detail();
        final error = result.exceptionOrNull() as RestException;

        expect(result.isError(), isTrue);
        expect(result.exceptionOrNull(), isA<RestException>());
        expect(error.statusCode, 500);

        verify(() => datasourceMock.detail()).called(1);
      });
    });

    group("login", () {
      late UserLoginParam input;

      test(
        'deve retornar Success<String> quando login for bem sucedido',
        () async {
          input = UserLoginParam(email: 'test@email.com', password: '123');

          when(
            () => datasourceMock.login(input),
          ).thenAnswer((_) async => 'token_123');

          final result = await repository.login(input);

          expect(result.isSuccess(), isTrue);
          expect(result.getOrThrow(), isA<String>());
          expect(result.getOrNull(), 'token_123');

          verify(() => datasourceMock.login(input)).called(1);
        },
      );
      test('deve retornar Failure quando ocorrer DioException', () async {
        input = UserLoginParam(email: 'test@email.com', password: '123');

        when(() => datasourceMock.login(input)).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 500,
            ),
          ),
        );

        final result = await repository.login(input);
        final error = result.exceptionOrNull() as RestException;

        expect(result.isError(), isTrue);
        expect(result.exceptionOrNull(), isA<RestException>());
        expect(error.statusCode, 500);

        verify(() => datasourceMock.login(input)).called(1);
      });
    });

    group("register", () {
      late UserRegisterParam input;

      test('deve retornar Success<UserEntity>', () async {
        input = UserRegisterParam(
          name: 'Lázaro',
          email: 'email@test.com',
          password: '123',
        );

        final user = UserModel(
          id: '1',
          name: 'Lázaro',
          email: 'email@test.com',
          createdAt: "10/10/2025",
        );

        when(
          () => datasourceMock.register(input),
        ).thenAnswer((_) async => user);

        final result = await repository.register(input);

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), isA<UserEntity>());
        expect(result.getOrNull(), user);

        verify(() => datasourceMock.register(input)).called(1);
      });

      test('deve retornar Failure quando ocorrer DioException', () async {
        input = UserRegisterParam(
          name: "Lázaro",
          email: 'test@email.com',
          password: '123',
        );

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
      late UserUpdateParam input;

      test('deve retornar Success<UserEntity>', () async {
        input = UserUpdateParam(name: 'Novo Nome');

        final user = UserModel(
          id: '1',
          name: 'Novo Nome',
          email: 'email@test.com',
          createdAt: "10/10/2025",
          updatedAt: "11/10/2025",
        );

        when(() => datasourceMock.update(input)).thenAnswer((_) async => user);

        final result = await repository.update(input);

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), isA<UserEntity>());
        expect(result.getOrNull(), user);

        verify(() => datasourceMock.update(input)).called(1);
      });

      test('deve retornar Failure quando ocorrer DioException', () async {
        input = UserUpdateParam(name: 'Novo Nome');

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
  });
}
