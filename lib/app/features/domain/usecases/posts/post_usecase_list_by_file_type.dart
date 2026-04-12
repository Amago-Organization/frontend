// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amago/app/features/domain/repositories/post_repository.dart';
import 'package:result_dart/result_dart.dart';

import 'package:amago/app/core/usecase/usecase.dart';
import 'package:amago/app/features/domain/entities/post_entity.dart';

class PostUsecaseListByFileType implements UseCase<List<PostEntity>, String> {
  final PostRepository postRepository;
  PostUsecaseListByFileType({required this.postRepository});

  @override
  AsyncResult<List<PostEntity>> call(String params) async {
    return await postRepository.listByFileType(params);
  }
}
