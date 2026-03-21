import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pulse_post/app/data/services/local/local_storage_service.dart';
import 'package:pulse_post/app/data/services/messages/result_message_service.dart';
import 'package:pulse_post/app/domain/dtos/user/user_detail_dto.dart';
import 'package:pulse_post/app/domain/dtos/user/user_login_dto.dart';
import 'package:pulse_post/app/domain/dtos/user/user_register_dto.dart';
import 'package:pulse_post/app/domain/dtos/user/user_token_dto.dart';
import 'package:pulse_post/app/domain/dtos/user/user_update_dto.dart';
import 'package:pulse_post/app/domain/repositories/user_repository.dart';
import 'package:pulse_post/app/presentation/viewModels/user/user_view_model.dart';
import 'package:pulse_post/app/utils/constants/local/local_storage_constant.dart';
import 'package:result_dart/result_dart.dart';

class UserRepositoryMock extends Mock implements UserRepository {}

class LocalStorageServiceMock extends Mock implements LocalStorageService {}

class ResultMessageServiceMock extends Mock implements ResultMessageService {}

void main() {
  late UserRepositoryMock userRepositoryMock;
  late LocalStorageServiceMock localStorageServiceMock;
  late ResultMessageServiceMock resultMessageServiceMock;
  late UserViewModel userViewModel;

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
    userRepositoryMock = UserRepositoryMock();
    localStorageServiceMock = LocalStorageServiceMock();
    resultMessageServiceMock = ResultMessageServiceMock();
    userViewModel = UserViewModel(
      userRepository: userRepositoryMock,
      localStorageService: localStorageServiceMock,
      resultMessageService: resultMessageServiceMock,
    );
  });

  group("UserViewModel", () {
    group("register", () {
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

        when(
          () => userRepositoryMock.register(userRegisterDto),
        ).thenAnswer((invocation) async => Success(userDetailDto));
        when(
          () =>
              resultMessageServiceMock.showMessageSuccess(any(), any(), any()),
        ).thenReturn(null);

        await userViewModel.register(userRegisterDto);

        expect(userViewModel.serverError, false);
        expect(userViewModel.isLoading, false);
        expect(userViewModel.userDetailDto, equals(null));
        expect(
          database.any((element) => userDetailDto.email == element['email']),
          isTrue,
        );

        verify(() => userRepositoryMock.register(userRegisterDto)).called(1);
        verify(
          () =>
              resultMessageServiceMock.showMessageSuccess(any(), any(), any()),
        ).called(1);
      });
    });

    group("login", () {
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

        when(
          () => userRepositoryMock.login(userLoginDto),
        ).thenAnswer((invocation) async => Success(userTokenDto));
        when(
          () => localStorageServiceMock.put(
            LocalStorageConstant.token,
            userTokenDto,
          ),
        ).thenAnswer((invocation) async => {});
        when(
          () =>
              resultMessageServiceMock.showMessageSuccess(any(), any(), any()),
        ).thenReturn(null);

        await userViewModel.login(userLoginDto);

        expect(userViewModel.token, equals(userTokenDto.toString()));
        expect(userViewModel.serverError, false);
        expect(userViewModel.isLoading, false);
        expect(userViewModel.userDetailDto, equals(null));

        verify(() => userRepositoryMock.login(userLoginDto)).called(1);
        verify(
          () => localStorageServiceMock.put(
            LocalStorageConstant.token,
            userTokenDto,
          ),
        ).called(1);
        verify(
          () =>
              resultMessageServiceMock.showMessageSuccess(any(), any(), any()),
        ).called(1);
      });
    });

    group("logout", () {
      test("Saindo do sistema", () async {
        userViewModel.token = "token_aleatório";
        when(
          () => localStorageServiceMock.delete(LocalStorageConstant.token),
        ).thenAnswer((invocation) async => {});

        await userViewModel.logout();

        expect(userViewModel.token, equals(null));
        expect(userViewModel.isLoading, false);
        expect(userViewModel.userDetailDto, equals(null));

        verify(
          () => localStorageServiceMock.delete(LocalStorageConstant.token),
        ).called(1);
      });
    });

    group("details", () {
      late UserDetailDto userDetailDto;
      test("Detalhes Corretos do Usuário Logado", () async {
        userDetailDto = UserDetailDto.fromMap(database.first);

        when(
          () => userRepositoryMock.detail(),
        ).thenAnswer((invocation) async => Success(userDetailDto));

        await userViewModel.details();

        expect(userViewModel.isLoading, false);
        expect(userViewModel.serverError, false);
        expect(userViewModel.userDetailDto, equals(userDetailDto));

        verify(() => userRepositoryMock.detail()).called(1);
      });
    });

    group("loadToken", () {
      late UserTokenDto userTokenDto;
      test("Pegando o token", () async {
        userTokenDto = UserTokenDto(token: "token_aleatório");
        when(
          () => localStorageServiceMock.get(LocalStorageConstant.token),
        ).thenAnswer((invocation) async => userTokenDto.token);

        await userViewModel.loadToken();

        expect(userViewModel.token, userTokenDto.token);

        verify(() => localStorageServiceMock.get(LocalStorageConstant.token));
      });
    });

    group("update", () {
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

        when(
          () => userRepositoryMock.update(userUpdateDto, any()),
        ).thenAnswer((invocation) async => Success(userDetailDto));
        when(
          () =>
              resultMessageServiceMock.showMessageSuccess(any(), any(), any()),
        ).thenReturn(null);

        await userViewModel.update(userUpdateDto, null);

        expect(userViewModel.isLoading, isFalse);
        expect(userViewModel.serverError, isFalse);
        expect(userViewModel.userDetailDto, equals(null));
        expect(
          database.any(
            (element) =>
                element['email'] == 'lazaro@gmail.com' &&
                element['name'] == userDetailDto.name,
          ),
          isTrue,
        );

        verify(() => userRepositoryMock.update(userUpdateDto, any())).called(1);
        verify(
          () =>
              resultMessageServiceMock.showMessageSuccess(any(), any(), any()),
        ).called(1);
      });
    });
  });
}
