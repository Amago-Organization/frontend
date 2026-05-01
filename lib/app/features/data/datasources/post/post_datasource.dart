import 'package:amago/app/features/data/models/post_model.dart';
import 'package:amago/app/features/domain/params/posts/post_register_param.dart';
import 'package:amago/app/features/domain/params/posts/post_update_param.dart';

abstract interface class PostDatasource {
  Future<List<PostModel>> list();
  Future<List<PostModel>> listByFileType(String type);
  Future<PostModel> register(PostRegisterParam data);
  Future<PostModel> update(PostUpdateParam data);
  Future<Object> remove(String id);
  Future<PostModel> detail(String id);
}
