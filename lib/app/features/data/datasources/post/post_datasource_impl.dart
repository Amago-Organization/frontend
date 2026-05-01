// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:amago/app/core/services/client/client_service.dart';
import 'package:amago/app/core/utils/apis/api_backend.dart';
import 'package:amago/app/features/data/mappers/post_mapper.dart';
import 'package:amago/app/features/data/models/post_model.dart';
import 'package:amago/app/features/domain/params/posts/post_register_param.dart';
import 'package:amago/app/features/domain/params/posts/post_update_param.dart';
import 'package:result_dart/result_dart.dart';

import './post_datasource.dart';

class PostDatasourceImpl implements PostDatasource {
  final ClientService clientService;
  PostDatasourceImpl({required this.clientService});

  @override
  Future<PostModel> detail(String id) async {
    final Response response = await clientService.get(
      "${ApiBackend.post}/$id",
      requiresAuth: true,
    );
    return PostModel.fromMap(response.data);
  }

  @override
  Future<List<PostModel>> list() async {
    final Response response = await clientService.get(
      "${ApiBackend.post}/list",
      requiresAuth: true,
    );
    final List<dynamic> result = response.data['posts'];
    return result
        .map((item) => PostModel.fromMap(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<PostModel>> listByFileType(String type) async {
    final Response response = await clientService.get(
      "${ApiBackend.post}/list/post-type/$type",
      requiresAuth: true,
    );
    final List<dynamic> result = response.data['posts'];
    return result
        .map((item) => PostModel.fromMap(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<PostModel> register(PostRegisterParam data) async {
    final FormData formData = FormData.fromMap({
      ...data.toMap(),
      if (data.file != null)
        'file': MultipartFile.fromBytes(
          await data.file!.readAsBytes(),
          filename: data.file!.path.split('/').last,
        ),
    });

    final Response response = await clientService.post(
      "${ApiBackend.post}/register",
      formData,
      requiresAuth: true,
      contentType: 'multipart/form-data',
    );
    return PostModel.fromMap(response.data);
  }

  @override
  Future<Object> remove(String id) async {
    await clientService.delete(
      "${ApiBackend.post}/delete/$id",
      requiresAuth: true,
    );
    return Unit;
  }

  @override
  Future<PostModel> update(PostUpdateParam data) async {
    final FormData formData = FormData.fromMap({
      ...data.toMap(),
      if (data.file != null)
        'file': MultipartFile.fromBytes(
          await data.file!.readAsBytes(),
          filename: data.file!.path.split('/').last,
        ),
    });

    final Response response = await clientService.patch(
      "${ApiBackend.post}/update/${data.id}",
      formData,
      requiresAuth: true,
      contentType: 'multipart/form-data',
    );
    return PostModel.fromMap(response.data);
  }
}
