// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pulse_post/app/features/domain/entities/user_entity.dart';
import 'package:pulse_post/app/features/domain/params/users/user_register_param.dart';
import 'package:result_dart/result_dart.dart';

import 'package:pulse_post/app/core/usecase/usecase.dart';
import 'package:pulse_post/app/features/domain/repositories/user_repository.dart';

class UserUsecaseRegister implements UseCase<UserEntity, UserRegisterParam> {
  final UserRepository userRepository;
  UserUsecaseRegister({required this.userRepository});

  @override
  AsyncResult<UserEntity> call(UserRegisterParam params) async{
    return await userRepository.register(params);
  }
}
