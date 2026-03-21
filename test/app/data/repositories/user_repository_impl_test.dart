import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pulse_post/app/data/repositories/user_repository_impl.dart';
import 'package:pulse_post/app/data/services/client/client_service.dart';
import 'package:pulse_post/app/domain/dtos/user/user_detail_dto.dart';
import 'package:pulse_post/app/domain/dtos/user/user_login_dto.dart';
import 'package:pulse_post/app/domain/dtos/user/user_register_dto.dart';
import 'package:pulse_post/app/domain/dtos/user/user_token_dto.dart';
import 'package:pulse_post/app/domain/dtos/user/user_update_dto.dart';
import 'package:pulse_post/app/domain/repositories/user_repository.dart';

class ClientServiceMock extends Mock implements ClientService {}

void main() {
  late ClientServiceMock clientServiceMock;
  late UserRepository userRepository;
  late List<Map<String, dynamic>> database = [
    {
      "id": "1de0d61a-447f-44af-b4e5-f8661f865306",
      "name": "Lázaro",
      "email": "lazaro@gmail.com",
      "password": "123456",
      "bio": null,
      "image": null,
      "created": "2026-01-09T21:12:42.477639958",
      "updated": null,
    },
    {
      "id": "2de0d61a-447f-44af-b4e5-f8661f865306",
      "name": "Luis",
      "email": "luis@gmail.com",
      "password": "654321",
      "bio": null,
      "image": null,
      "created": "2026-01-09T21:12:42.477639958",
      "updated": null,
    },
  ];

  setUp(() {
    clientServiceMock = ClientServiceMock();
    userRepository = UserRepositoryImpl(clientService: clientServiceMock);
  });

  group("UserRepositoryImpl", () {
    group('Register', () {
      late UserRegisterDto userRegisterDto;
      late UserDetailDto userDetailDto;
      test("Novo Usuário", () async {
        userRegisterDto = UserRegisterDto(
          name: 'test01',
          email: "test01@gmail.com",
          password: "012345",
        );

        final inDatabase = database.any(
          (element) => userRegisterDto.email == element['email'],
        );

        if (!inDatabase) {
          userDetailDto = UserDetailDto(
            id: "9090",
            name: userRegisterDto.name,
            email: userRegisterDto.email,
            created: "2026-01-09T21:12:42.477639958",
          );

          database.add(userRegisterDto.toMap());
        }

        final response = Response(
          requestOptions: RequestOptions(),
          data: userDetailDto.toMap(),
        );

        when(
          () => clientServiceMock.post(any(), userRegisterDto.toMap()),
        ).thenAnswer((invocation) async => response);

        final result = await userRepository.register(userRegisterDto);

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), isA<UserDetailDto>());
        expect(result.getOrNull()?.email, equals(userDetailDto.email));
        expect(
          database.any(
            (element) => result.getOrNull()?.email == element['email'],
          ),
          isTrue,
        );

        verify(
          () => clientServiceMock.post(any(), userRegisterDto.toMap()),
        ).called(1);
      });
    });

    group("Login", () {
      late UserLoginDto userLoginDto;
      late UserTokenDto userTokenDto;
      test("Credenciais Corretas", () async {
        userLoginDto = UserLoginDto(
          email: "luis@gmail.com",
          password: "654321",
        );

        final inDatabase = database.any(
          (element) => userLoginDto.email == element['email'],
        );

        if (inDatabase) {
          userTokenDto = UserTokenDto(token: "token_aleatório");
        }

        final response = Response(
          requestOptions: RequestOptions(),
          data: userTokenDto.toMap(),
        );

        when(
          () => clientServiceMock.post(any(), userLoginDto.toMap()),
        ).thenAnswer((invocation) async => response);
        final result = await userRepository.login(userLoginDto);

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), isA<UserTokenDto>());
        expect(result.getOrNull()?.token, equals(userTokenDto.token));

        verify(
          () => clientServiceMock.post(any(), userLoginDto.toMap()),
        ).called(1);
      });
    });

    group('Detail', () {
      late UserDetailDto userDetailDto;
      test("Detalhes Corretos do Usuário Logado", () async {
        userDetailDto = UserDetailDto.fromMap(database.first);

        final response = Response(
          requestOptions: RequestOptions(),
          data: userDetailDto.toMap(),
        );

        when(
          () => clientServiceMock.get(any(), requiresAuth: true),
        ).thenAnswer((invocation) async => response);

        final result = await userRepository.detail();

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), isA<UserDetailDto>());
        expect(result.getOrNull()?.email, equals(userDetailDto.email));

        verify(
          () => clientServiceMock.get(any(), requiresAuth: true),
        ).called(1);
      });
    });

    group('Update', () {
      late UserUpdateDto userUpdateDto;
      late UserDetailDto userDetailDto;
      test("Atualizando Dados de Usuário Logado", () async {
        userUpdateDto = UserUpdateDto(name: 'Alexandre');

        for (var i = 0; i < database.length; i++) {
          if (database[i]['email'] == 'lazaro@gmail.com') {
            database[i] = {...database[i], ...userUpdateDto.toMap()};
            userDetailDto = UserDetailDto.fromMap(database[i]);
          }
        }

        final response = Response(
          requestOptions: RequestOptions(),
          data: userDetailDto.toMap(),
        );

        when(
          () => clientServiceMock.patch(
            any(),
            any(),
            requiresAuth: true,
            contentType: 'multipart/form-data',
          ),
        ).thenAnswer((invocation) async => response);

        final result = await userRepository.update(userUpdateDto, null);

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), isA<UserDetailDto>());
        expect(result.getOrNull()?.name, equals(userDetailDto.name));
        expect(
          database.any(
            (element) =>
                element['email'] == 'lazaro@gmail.com' &&
                element['name'] == userDetailDto.name,
          ),
          isTrue,
        );

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
  });
}
