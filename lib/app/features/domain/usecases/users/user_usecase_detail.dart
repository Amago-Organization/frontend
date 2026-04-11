// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pulse_post/app/core/usecase/usecase.dart';
import 'package:pulse_post/app/features/domain/entities/user_entity.dart';
import 'package:pulse_post/app/features/domain/repositories/user_repository.dart';
import 'package:result_dart/result_dart.dart';

class UserUsecaseDetail implements UseCase<UserEntity, NoParams> {
  final UserRepository userRepository;
  UserUsecaseDetail({required this.userRepository});

  @override
  AsyncResult<UserEntity> call(NoParams params) async {
    return await userRepository.detail();
  }
}
