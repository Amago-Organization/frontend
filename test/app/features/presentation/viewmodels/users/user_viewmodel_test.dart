import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pulse_post/app/core/services/local/local_storage_service.dart';
import 'package:pulse_post/app/core/services/messages/result_message_service.dart';
import 'package:pulse_post/app/features/domain/entities/user_entity.dart';
import 'package:pulse_post/app/features/domain/params/users/user_login_param.dart';
import 'package:pulse_post/app/features/domain/usecases/users/user_usecase_detail.dart';
import 'package:pulse_post/app/features/domain/usecases/users/user_usecase_login.dart';
import 'package:pulse_post/app/features/domain/usecases/users/user_usecase_register.dart';
import 'package:pulse_post/app/features/domain/usecases/users/user_usecase_update.dart';
import 'package:pulse_post/app/features/presentation/viewmodels/users/user_viewmodel.dart';
import 'package:result_dart/result_dart.dart';

class UserUsecaseLoginMock extends Mock implements UserUsecaseLogin {}

class UserUsecaseRegisterMock extends Mock implements UserUsecaseRegister {}

class UserUsecaseDetailMock extends Mock implements UserUsecaseDetail {}

class UserUsecaseUpdateMock extends Mock implements UserUsecaseUpdate {}

class LocalStorageServiceMock extends Mock implements LocalStorageService {}

class ResultMessageServiceMock extends Mock implements ResultMessageService {}

void main() {
  late UserUsecaseLoginMock loginMock;
  late UserUsecaseRegisterMock registerMock;
  late UserUsecaseDetailMock detailMock;
  late UserUsecaseUpdateMock updateMock;
  late LocalStorageServiceMock localStorageMock;
  late ResultMessageServiceMock messageMock;
  late UserViewmodel viewmodel;

  late List<UserEntity> database = [
    UserEntity(
      id: "1",
      name: "Lázaro",
      email: "lazaro@gmail.com",
      bio: "bio 01",
      image: "image.png",
      createdAt: "10/10/2025",
    ),
    UserEntity(
      id: "2",
      name: "Luis",
      email: "luis@gmail.com",
      bio: "bio 02",
      createdAt: "10/10/2025",
    ),
  ];

  setUp(() {
    loginMock = UserUsecaseLoginMock();
    registerMock = UserUsecaseRegisterMock();
    detailMock = UserUsecaseDetailMock();
    updateMock = UserUsecaseUpdateMock();
    localStorageMock = LocalStorageServiceMock();
    messageMock = ResultMessageServiceMock();

    viewmodel = UserViewmodel(
      loginUsecase: loginMock,
      registerUsecase: registerMock,
      detailUsecase: detailMock,
      updateUsecase: updateMock,
      localStorageService: localStorageMock,
      resultMessageService: messageMock,
    );
  });

  group("UserViewmodel", () {
    group("Login", () {
      test("Deve logar com sucesso", () async {
        final param = UserLoginParam(
          email: "lazaro@gmail.com",
          password: "123456",
        );
        late String output;
        final isValid = database.any((element) => element.email == param.email);

        if (isValid) {
          output = "token123";
        }

        when(() => loginMock(param)).thenAnswer((_) async => Success(output));

        when(
          () => localStorageMock.put(any(), output),
        ).thenAnswer((_) async {});

        when(
          () => messageMock.showMessageSuccess(any(), any()),
        ).thenReturn(null);

        await viewmodel.login(param);

        expect(viewmodel.serverError, false);
        expect(viewmodel.token, output);

        verify(() => loginMock(param)).called(1);
        verify(() => localStorageMock.put(any(), output)).called(1);
        verify(() => messageMock.showMessageSuccess(any(), any())).called(1);
      });

      test("Deve retornar erro no login", () async {
        final param = UserLoginParam(
          email: "lazaro@gmail.com",
          password: "123456",
        );

        when(
          () => loginMock(param),
        ).thenAnswer((_) async => Failure(Exception()));

        await viewmodel.login(param);

        expect(viewmodel.serverError, true);

        verify(() => loginMock(param)).called(1);
        verify(() => messageMock.showMessageError(any())).called(1);
      });
    });
  });
}
