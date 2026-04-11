// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:mobx/mobx.dart';
import 'package:pulse_post/app/core/exceptions/rest_exception.dart';

import 'package:pulse_post/app/core/services/local/remocao/local_storage_service.dart';
import 'package:pulse_post/app/core/services/messages/result_message_service.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/user/user_detail_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/user/user_login_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/user/user_register_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/user/user_update_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/repositories/user_repository.dart';
import 'package:pulse_post/app/core/utils/constants/local/local_storage_constant.dart';
import 'package:pulse_post/app/core/utils/constants/texts/text_constant.dart';

part 'user_view_model.g.dart';

class UserViewModel = UserViewModelBase with _$UserViewModel;

abstract class UserViewModelBase with Store {
  final UserRepository userRepository;
  final LocalStorageServiceFack localStorageService;
  final ResultMessageService resultMessageService;
  UserViewModelBase({
    required this.userRepository,
    required this.localStorageService,
    required this.resultMessageService,
  });

  @observable
  String? token;

  @observable
  bool isLoading = false;

  @observable
  UserDetailDto? userDetailDto;

  @observable
  bool serverError = false;

  @action
  Future<void> login(UserLoginDto data) async {
    isLoading = true;
    final result = await userRepository.login(data);

    result.fold(
      (success) async {
        serverError = false;
        token = success.toString();
        await localStorageService.put(
          LocalStorageConstant.token,
          result.getOrThrow(),
        );

        resultMessageService.showMessageSuccess(
          TextConstant.sucessLoggingAccountTitle,
          TextConstant.sucessLoggingAccountMessage,
        );
      },
      (failure) async {
        resultMessageService.showMessageError(
          TextConstant.errorExecutingMessage,
        );
      },
    );
    isLoading = false;
  }

  @action
  Future register(UserRegisterDto data) async {
    isLoading = true;
    final result = await userRepository.register(data);

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
        resultMessageService.showMessageError(
          TextConstant.errorExecutingMessage,
        );
      },
    );

    isLoading = false;
  }

  @action
  Future logout() async {
    isLoading = true;
    await localStorageService.delete(LocalStorageConstant.token);
    userDetailDto = null;
    token = null;
    isLoading = false;
  }

  @action
  Future details() async {
    isLoading = true;
    final result = await userRepository.detail();
    serverError = false;

    result.fold(
      (success) {
        serverError = false;
        userDetailDto = success;
      },
      (failure) async {
        if (failure is RestException &&
            (failure.statusCode == 500 || failure.statusCode == 403)) {
          serverError = true;
          await localStorageService.delete(LocalStorageConstant.token);
          userDetailDto = null;
        }
      },
    );

    isLoading = false;
  }

  @action
  Future<void> loadToken() async {
    token ??= await localStorageService.get(LocalStorageConstant.token);
  }


  @action
  Future update(UserUpdateDto data, File? file) async {
    isLoading = true;
    final result = await userRepository.update(data, file);
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
        resultMessageService.showMessageError(
          TextConstant.errorExecutingMessage,
        );
      },
    );
    isLoading = false;
  }


}
