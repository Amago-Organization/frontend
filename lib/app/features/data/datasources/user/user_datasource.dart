import 'package:amago/app/features/data/models/user_model.dart';
import 'package:amago/app/features/domain/params/users/user_login_param.dart';
import 'package:amago/app/features/domain/params/users/user_register_param.dart';
import 'package:amago/app/features/domain/params/users/user_update_param.dart';

abstract interface class UserDatasource {
  Future<UserModel> register(UserRegisterParam data);
  Future<String> login(UserLoginParam data);
  Future<UserModel> detail();
  Future<UserModel> update(UserUpdateParam data);
}
