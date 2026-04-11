// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:pulse_post/app/core/usecase/usecase.dart';
import 'package:pulse_post/app/features/domain/params/users/user_login_param.dart';
import 'package:pulse_post/app/features/domain/repositories/user_repository.dart';
import 'package:result_dart/result_dart.dart';

class UserUsecaseLogin implements UseCase<String, UserLoginParam> {
  final UserRepository userRepository;
  UserUsecaseLogin({required this.userRepository});

  @override
  AsyncResult<String> call(UserLoginParam params) async {
    return await userRepository.login(params);
  }
}
