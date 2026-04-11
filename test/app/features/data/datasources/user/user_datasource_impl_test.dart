import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pulse_post/app/core/services/client/client_service.dart';
import 'package:pulse_post/app/features/data/datasources/user/user_datasource.dart';
import 'package:pulse_post/app/features/data/datasources/user/user_datasource_impl.dart';
import 'package:pulse_post/app/features/data/mappers/user_mapper.dart';
import 'package:pulse_post/app/features/data/models/user_model.dart';
import 'package:pulse_post/app/features/domain/params/users/user_login_param.dart';
import 'package:pulse_post/app/features/domain/params/users/user_register_param.dart';
import 'package:pulse_post/app/features/domain/params/users/user_update_param.dart';

class ClientServiceMock extends Mock implements ClientService {}

void main() {
  late ClientServiceMock clientService;
  late UserDatasource datasource;

  setUp(() {
    clientService = ClientServiceMock();
    datasource = UserDatasourceImpl(clientService: clientService);
  });

  group('UserDatasourceImpl', () {
    group('login', () {
      test('deve retornar token quando sucesso', () async {
        final input = UserLoginParam(email: 'test@email.com', password: '123');

        when(() => clientService.post(any(), input.toMap())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(),
            data: {"token": "abc123"},
          ),
        );

        final result = await datasource.login(input);

        expect(result, 'abc123');

        verify(() => clientService.post(any(), input.toMap())).called(1);
      });

      test('deve lançar exceção quando falhar', () async {
        when(() => clientService.post(any(), any())).thenThrow(Exception());

        expect(
          () => datasource.login(UserLoginParam(email: '', password: '')),
          throwsException,
        );
      });

      test('deve falhar se token for nulo', () async {
        when(() => clientService.post(any(), any())).thenAnswer(
          (_) async =>
              Response(requestOptions: RequestOptions(), data: {"token": null}),
        );

        expect(
          () => datasource.login(UserLoginParam(email: '', password: '')),
          throwsA(isA<TypeError>()),
        );
      });
    });

    group('register', () {
      test('deve retornar UserModel quando sucesso', () async {
        final input = UserRegisterParam(
          name: 'Lázaro',
          email: 'test@email.com',
          password: '123',
        );

        final UserModel output = UserModel(
          id: "1",
          name: input.name,
          email: input.email,
          createdAt: '10/10/2025',
        );

        when(() => clientService.post(any(), input.toMap())).thenAnswer(
          (_) async =>
              Response(requestOptions: RequestOptions(), data: output.toMap()),
        );

        final result = await datasource.register(input);

        expect(result, isA<UserModel>());
        expect(result, output);
        expect(result.email, input.email);

        verify(() => clientService.post(any(), input.toMap())).called(1);
      });

      test('deve lançar exceção quando falhar', () async {
        when(() => clientService.post(any(), any())).thenThrow(Exception());

        expect(
          () => datasource.register(
            UserRegisterParam(name: '', email: '', password: ''),
          ),
          throwsException,
        );
        verify(() => clientService.post(any(), any())).called(1);
      });
    });

    group('detail', () {
      test('deve retornar detalhes do usuário autenticado', () async {
        final UserModel output = UserModel(
          id: "2",
          name: "test",
          email: "test@gmail.com",
          createdAt: '10/10/2025',
        );

        when(() => clientService.get(any(), requiresAuth: true)).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: output.toMap(),
          ),
        );

        final result = await datasource.detail();

        expect(result.id, output.id);
        expect(result.name, output.name);
        expect(result.email, output.email);
        expect(result.bio, output.bio);
        expect(result.image, output.image);
        expect(result.createdAt, output.createdAt);
        expect(result.updatedAt, output.updatedAt);

        verify(() => clientService.get(any(), requiresAuth: true)).called(1);
      });

      test('deve lançar exceção quando falhar', () async {
        when(
          () => clientService.get(any(), requiresAuth: true),
        ).thenThrow(Exception());

        expect(() => datasource.detail(), throwsException);

        verify(() => clientService.get(any(), requiresAuth: true)).called(1);
      });
    });

    group('update', () {
      test('deve atualizar usuário sem imagem', () async {
        final input = UserUpdateParam(name: 'Novo Nome', file: null);

        final UserModel output = UserModel(
          id: "2",
          name: input.name ?? "test",
          email: "test@gmail.com",
          createdAt: '10/10/2025',
        );

        when(
          () => clientService.patch(
            any(),
            any(),
            requiresAuth: true,
            contentType: 'multipart/form-data',
          ),
        ).thenAnswer(
          (_) async =>
              Response(requestOptions: RequestOptions(), data: output.toMap()),
        );

        final result = await datasource.update(input);
        expect(result, isA<UserModel>());
        expect(result, output);
        expect(result.name, input.name);

        verify(
          () => clientService.patch(
            any(),
            any(),
            requiresAuth: true,
            contentType: 'multipart/form-data',
          ),
        ).called(1);
      });

      test('deve lançar exceção quando falhar', () async {
        when(
          () => clientService.patch(
            any(),
            any(),
            requiresAuth: true,
            contentType: 'multipart/form-data',
          ),
        ).thenThrow(Exception());

        expect(
          () => datasource.update(UserUpdateParam(name: 'Teste')),
          throwsException,
        );

        verify(
          () => clientService.patch(
            any(),
            any(),
            requiresAuth: true,
            contentType: 'multipart/form-data',
          ),
        ).called(1);
      });
    });
  });
}
