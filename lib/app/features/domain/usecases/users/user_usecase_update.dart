// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:pulse_post/app/core/usecase/usecase.dart';
import 'package:pulse_post/app/features/domain/entities/user_entity.dart';
import 'package:pulse_post/app/features/domain/params/users/user_update_param.dart';
import 'package:pulse_post/app/features/domain/repositories/user_repository.dart';
import 'package:result_dart/result_dart.dart';

class UserUsecaseUpdate implements UseCase<UserEntity, UserUpdateParam> {
  final UserRepository userRepository;
  UserUsecaseUpdate({required this.userRepository});

  @override
  AsyncResult<UserEntity> call(UserUpdateParam params) async {
    return await userRepository.update(params);
  }
}
