// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:pulse_post/app/core/usecase/usecase.dart';
import 'package:pulse_post/app/features/domain/entities/post_entity.dart';
import 'package:pulse_post/app/features/domain/params/posts/post_register_param.dart';
import 'package:pulse_post/app/features/domain/repositories/post_repository.dart';

class PostUsecaseRegister implements UseCase<PostEntity, PostRegisterParam> {
  final PostRepository postRepository;
  PostUsecaseRegister({required this.postRepository});

  @override
  AsyncResult<PostEntity> call(PostRegisterParam params) async {
    return await postRepository.register(params);
  }
}
