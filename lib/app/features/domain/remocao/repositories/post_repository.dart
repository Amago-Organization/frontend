import 'dart:io';

import 'package:pulse_post/app/features/domain/remocao/dtos/post/post_detail_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/post/post_register_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/post/post_update_dto.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class PostRepository {
  AsyncResult<List<PostDetailDto>> list();
  AsyncResult<List<PostDetailDto>> listByFileType(String type);
  AsyncResult<PostDetailDto> register(PostRegisterDto data, File? file);
  AsyncResult<PostDetailDto> update(String id, PostUpdateDto data, File? file);
  AsyncResult<Object> remove(String id);
  AsyncResult<PostDetailDto> detail(String id);
}
