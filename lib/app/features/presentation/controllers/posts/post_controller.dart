// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:mobx/mobx.dart';
import 'package:amago/app/features/domain/entities/post_entity.dart';
import 'package:amago/app/features/domain/params/posts/post_register_param.dart';
import 'package:amago/app/features/domain/params/posts/post_update_param.dart';
import 'package:amago/app/features/presentation/viewmodels/posts/post_viewmodel.dart';

part 'post_controller.g.dart';

class PostController = PostControllerBase with _$PostController;

abstract class PostControllerBase with Store {
  final PostViewmodel postViewmodel;
  PostControllerBase({required this.postViewmodel});

  @computed
  bool get isLoading => postViewmodel.isLoading;

  @computed
  bool get isServerError => postViewmodel.serverError;

  @computed
  PostEntity? get post => postViewmodel.post;

  @computed
  List<PostEntity>? get postList => postViewmodel.postList;

  @computed
  List<PostEntity>? get postListByFileType => postViewmodel.postListByFileType;

  Future<void> list() async {
    await postViewmodel.list();
  }

  Future<void> listByFileType(String type) async {
    await postViewmodel.listByFileType(type);
  }

  Future<void> register(PostRegisterParam param) async {
    await postViewmodel.register(param);
  }

  Future<void> update(PostUpdateParam param) async {
    await postViewmodel.update(param);
  }

  Future<void> remove(String id) async {
    await postViewmodel.remove(id);
  }

  Future<void> detail(String id) async {
    await postViewmodel.detail(id);
  }
}
