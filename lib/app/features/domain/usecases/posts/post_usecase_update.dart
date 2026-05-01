// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amago/app/features/domain/params/posts/post_update_param.dart';
import 'package:amago/app/features/domain/repositories/post_repository.dart';
import 'package:result_dart/result_dart.dart';

import 'package:amago/app/core/usecase/usecase.dart';
import 'package:amago/app/features/domain/entities/post_entity.dart';

class PostUsecaseUpdate implements UseCase<PostEntity, PostUpdateParam> {
  final PostRepository postRepository;
  PostUsecaseUpdate({required this.postRepository});

  @override
  AsyncResult<PostEntity> call(PostUpdateParam params) async {
    return await postRepository.update(params);
  }
}
