import 'package:pulse_post/app/features/domain/entities/user_entity.dart';
import 'package:pulse_post/app/features/domain/params/users/user_login_param.dart';
import 'package:pulse_post/app/features/domain/params/users/user_register_param.dart';
import 'package:pulse_post/app/features/domain/params/users/user_update_param.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class UserRepository {
  AsyncResult<UserEntity> register(UserRegisterParam data);
  AsyncResult<String> login(UserLoginParam data);
  AsyncResult<UserEntity> detail();
  AsyncResult<UserEntity> update(UserUpdateParam data);
}
