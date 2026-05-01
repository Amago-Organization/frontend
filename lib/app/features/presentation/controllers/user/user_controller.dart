// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobx/mobx.dart';
import 'package:amago/app/features/domain/entities/user_entity.dart';
import 'package:amago/app/features/domain/params/users/user_login_param.dart';
import 'package:amago/app/features/domain/params/users/user_register_param.dart';
import 'package:amago/app/features/domain/params/users/user_update_param.dart';

import 'package:amago/app/features/presentation/viewmodels/users/user_viewmodel.dart';

part 'user_controller.g.dart';

class UserController = UserControllerBase with _$UserController;

abstract class UserControllerBase with Store {
  final UserViewmodel userViewmodel;
  UserControllerBase({required this.userViewmodel});

  @computed
  bool get isTokenValid => userViewmodel.token != null;

  @computed
  bool get isLoading => userViewmodel.isLoading;

  @computed
  bool get isServerError => userViewmodel.serverError;

  @computed
  UserEntity? get user => userViewmodel.user;

  Future<void> login(UserLoginParam params) async {
    await userViewmodel.login(params);
  }

  Future<void> register(UserRegisterParam params) async {
    await userViewmodel.register(params);
  }

  Future<void> logout() async {
    await userViewmodel.logout();
  }

  Future<void> load() async {
    await userViewmodel.details();
    await userViewmodel.loadToken();
  }

  Future<void> update(UserUpdateParam params) async {
    await userViewmodel.update(params);
  }
}
