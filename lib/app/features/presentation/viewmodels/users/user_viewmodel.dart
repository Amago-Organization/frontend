// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobx/mobx.dart';
import 'package:amago/app/core/errors/error_handler.dart';
import 'package:amago/app/core/exceptions/rest_exception.dart';

import 'package:amago/app/core/services/local/local_storage_service.dart';
import 'package:amago/app/core/services/messages/result_message_service.dart';
import 'package:amago/app/core/usecase/usecase.dart';
import 'package:amago/app/core/utils/constants/local/local_storage_constant.dart';
import 'package:amago/app/core/utils/constants/texts/text_constant.dart';
import 'package:amago/app/features/domain/entities/user_entity.dart';
import 'package:amago/app/features/domain/params/users/user_login_param.dart';
import 'package:amago/app/features/domain/params/users/user_register_param.dart';
import 'package:amago/app/features/domain/params/users/user_update_param.dart';
import 'package:amago/app/features/domain/usecases/users/user_usecase_detail.dart';
import 'package:amago/app/features/domain/usecases/users/user_usecase_login.dart';
import 'package:amago/app/features/domain/usecases/users/user_usecase_register.dart';
import 'package:amago/app/features/domain/usecases/users/user_usecase_update.dart';

part 'user_viewmodel.g.dart';

class UserViewmodel = UserViewmodelBase with _$UserViewmodel;

abstract class UserViewmodelBase with Store {
  final UserUsecaseLogin loginUsecase;
  final UserUsecaseRegister registerUsecase;
  final UserUsecaseDetail detailUsecase;
  final UserUsecaseUpdate updateUsecase;

  final LocalStorageService localStorageService;
  final ResultMessageService resultMessageService;
  UserViewmodelBase({
    required this.loginUsecase,
    required this.registerUsecase,
    required this.detailUsecase,
    required this.updateUsecase,
    required this.localStorageService,
    required this.resultMessageService,
  });

  @observable
  String? token;

  @observable
  bool isLoading = false;

  @observable
  UserEntity? user;

  @observable
  bool serverError = false;

  @action
  Future<void> login(UserLoginParam data) async {
    isLoading = true;

    final result = await loginUsecase(data);

    result.fold(
      (success) async {
        serverError = false;
        token = success;

        await localStorageService.put(LocalStorageConstant.token, success);

        resultMessageService.showMessageSuccess(
          TextConstant.sucessLoggingAccountTitle,
          TextConstant.sucessLoggingAccountMessage,
        );
      },
      (failure) {
        serverError = true;

        resultMessageService.showMessageError(getErrorMessage(failure));
      },
    );

    isLoading = false;
  }

  @action
  Future<void> register(UserRegisterParam data) async {
    isLoading = true;

    final result = await registerUsecase(data);

    result.fold(
      (success) {
        serverError = false;

        resultMessageService.showMessageSuccess(
          TextConstant.sucessRegisterAccountTitle,
          TextConstant.sucessRegisterAccountMessage,
        );
      },
      (failure) {
        serverError = true;

        resultMessageService.showMessageError(getErrorMessage(failure));
      },
    );

    isLoading = false;
  }

  @action
  Future<void> details() async {
    if (token == null) return;

    isLoading = true;

    final result = await detailUsecase(NoParams());

    result.fold(
      (success) {
        serverError = false;
        user = success;
      },
      (failure) async {
        if (failure is RestException &&
            (failure.statusCode == 401 || failure.statusCode == 403)) {
          serverError = false;
          await logout();
          return;
        }

        serverError = true;
        resultMessageService.showMessageError(getErrorMessage(failure));
      },
    );

    isLoading = false;
  }

  @action
  Future<void> update(UserUpdateParam data) async {
    isLoading = true;

    final result = await updateUsecase(data);

    result.fold(
      (success) {
        serverError = false;

        resultMessageService.showMessageSuccess(
          TextConstant.sucessUpdateUserTitle,
          TextConstant.sucessUpdateUserMessage,
        );
      },
      (failure) {
        serverError = true;

        resultMessageService.showMessageError(getErrorMessage(failure));
      },
    );

    isLoading = false;
  }

  @action
  Future<void> logout() async {
    isLoading = true;

    await localStorageService.delete(LocalStorageConstant.token);

    user = null;
    token = null;
    serverError = false;

    isLoading = false;
  }

  @action
  Future<void> loadToken() async {
    final storedToken = await localStorageService.get(LocalStorageConstant.token);
    token ??= storedToken?.trim().isEmpty == true ? null : storedToken;
  }
}
