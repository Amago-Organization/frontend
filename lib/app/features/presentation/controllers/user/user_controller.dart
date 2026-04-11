// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:mobx/mobx.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/user/user_detail_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/user/user_login_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/user/user_register_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/user/user_update_dto.dart';

import 'package:pulse_post/app/features/presentation/viewmodels/remocao/user/user_view_model.dart';

part 'user_controller.g.dart';

class UserController = UserControllerBase with _$UserController;

abstract class UserControllerBase with Store {
  final UserViewModel userViewModel;
  UserControllerBase({required this.userViewModel});

  @computed
  bool get isTokenValid => userViewModel.token != null;

  @computed
  bool get isLoading => userViewModel.isLoading;

  @computed
  bool get isServerError => userViewModel.serverError;

  @computed
  UserDetailDto? get user => userViewModel.userDetailDto;

  Future<void> login(UserLoginDto data) async {
    await userViewModel.login(data);
  }

  Future<void> register(UserRegisterDto data) async {
    await userViewModel.register(data);
  }

  Future<void> logout() async {
    await userViewModel.logout();
  }

  Future<void> load() async {
    await userViewModel.details();
    await userViewModel.loadToken();
  }

  Future<void> update(UserUpdateDto data, File? file) async {
    await userViewModel.update(data, file);
  }
}
