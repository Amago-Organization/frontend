import 'package:pulse_post/app/features/domain/entities/post_entity.dart';
import 'package:pulse_post/app/features/domain/params/posts/post_register_param.dart';
import 'package:pulse_post/app/features/domain/params/posts/post_update_param.dart';

import 'package:result_dart/result_dart.dart';

abstract interface class PostRepository {
  AsyncResult<List<PostEntity>> list();
  AsyncResult<List<PostEntity>> listByFileType(String type);
  AsyncResult<PostEntity> register(PostRegisterParam data);
  AsyncResult<PostEntity> update(PostUpdateParam data);
  AsyncResult<Object> remove(String id);
  AsyncResult<PostEntity> detail(String id);
}
