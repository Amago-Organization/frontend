// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amago/app/features/domain/repositories/post_repository.dart';
import 'package:result_dart/result_dart.dart';

import 'package:amago/app/core/usecase/usecase.dart';
import 'package:amago/app/features/domain/entities/post_entity.dart';

class PostUsecaseList implements UseCase<List<PostEntity>, NoParams> {
  final PostRepository postRepository;
  PostUsecaseList({required this.postRepository});

  @override
  AsyncResult<List<PostEntity>> call(NoParams params) async {
    return await postRepository.list();
  }
}
