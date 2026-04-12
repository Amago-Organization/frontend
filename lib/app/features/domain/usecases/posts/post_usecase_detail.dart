// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amago/app/features/domain/entities/post_entity.dart';
import 'package:amago/app/features/domain/repositories/post_repository.dart';
import 'package:result_dart/result_dart.dart';

import 'package:amago/app/core/usecase/usecase.dart';

class PostUsecaseDetail implements UseCase<PostEntity, String> {
  final PostRepository postRepository;
  PostUsecaseDetail({required this.postRepository});

  @override
  AsyncResult<PostEntity> call(String params) async {
    return await postRepository.detail(params);
  }
}
