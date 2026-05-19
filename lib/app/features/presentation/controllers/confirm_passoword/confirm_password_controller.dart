import 'package:mobx/mobx.dart';
part 'confirm_password_controller.g.dart';

class ConfirmPasswordController = ConfirmPasswordControllerBase with _$ConfirmPasswordController;

abstract class ConfirmPasswordControllerBase with Store {
  @observable
  String password = '';

  @observable
  String confirmPassword = '';

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value;
  }

  @computed
  bool get passwordsMatch =>
      password.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      password == confirmPassword;
}