// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pulse_post/app/features/domain/repositories/post_repository.dart';
import 'package:result_dart/result_dart.dart';

import 'package:pulse_post/app/core/usecase/usecase.dart';

class PostUsecaseRemove implements UseCase<Object, String> {
  final PostRepository postRepository;
  PostUsecaseRemove({required this.postRepository});

  @override
  AsyncResult<Object> call(String params) async {
    return await postRepository.remove(params);
  }
}
