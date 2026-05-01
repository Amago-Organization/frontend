// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:amago/app/core/exceptions/rest_exception.dart';
import 'package:amago/app/core/utils/constants/texts/text_constant.dart';
import 'package:result_dart/result_dart.dart';

import 'package:amago/app/features/data/datasources/post/post_datasource.dart';
import 'package:amago/app/features/domain/entities/post_entity.dart';
import 'package:amago/app/features/domain/params/posts/post_register_param.dart';
import 'package:amago/app/features/domain/params/posts/post_update_param.dart';
import 'package:amago/app/features/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostDatasource datasource;
  PostRepositoryImpl({required this.datasource});

  @override
  AsyncResult<PostEntity> detail(String id) async {
    try {
      final result = await datasource.detail(id);
      return Success(result);
    } on DioException catch (e) {
      return Failure(
        RestException(
          message: TextConstant.errorExecutingMessage,
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    }
  }

  @override
  AsyncResult<List<PostEntity>> list() async {
    try {
      final result = await datasource.list();
      return Success(result);
    } on DioException catch (e) {
      return Failure(
        RestException(
          message: TextConstant.errorExecutingMessage,
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    }
  }

  @override
  AsyncResult<List<PostEntity>> listByFileType(String type) async {
    try {
      final result = await datasource.listByFileType(type);
      return Success(result);
    } on DioException catch (e) {
      return Failure(
        RestException(
          message: TextConstant.errorExecutingMessage,
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    }
  }

  @override
  AsyncResult<PostEntity> register(PostRegisterParam data) async {
    try {
      final result = await datasource.register(data);
      return Success(result);
    } on DioException catch (e) {
      return Failure(
        RestException(
          message: TextConstant.errorExecutingMessage,
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    }
  }

  @override
  AsyncResult<Object> remove(String id) async {
    try {
      final result = await datasource.remove(id);
      return Success(result);
    } on DioException catch (e) {
      return Failure(
        RestException(
          message: TextConstant.errorExecutingMessage,
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    }
  }

  @override
  AsyncResult<PostEntity> update(PostUpdateParam data) async {
    try {
      final result = await datasource.update(data);
      return Success(result);
    } on DioException catch (e) {
      return Failure(
        RestException(
          message: TextConstant.errorExecutingMessage,
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    }
  }
}
