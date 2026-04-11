// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pulse_post/app/core/exceptions/rest_exception.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/post/post_register_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/post/post_update_dto.dart';
import 'package:pulse_post/app/core/utils/apis/api_backend.dart';
import 'package:pulse_post/app/core/utils/constants/texts/text_constant.dart';
import 'package:result_dart/result_dart.dart';

import 'package:pulse_post/app/core/services/client/client_service.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/post/post_detail_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final ClientService clientService;
  PostRepositoryImpl({required this.clientService});

  @override
  AsyncResult<List<PostDetailDto>> list() async {
    try {
      final Response response = await clientService.get(
        "${ApiBackend.post}/list",
        requiresAuth: true,
      );
      final List<dynamic> resultList = response.data['posts'];
      final List<PostDetailDto> dataList = resultList
          .map((item) => PostDetailDto.fromMap(item as Map<String, dynamic>))
          .toList();
      return Success(dataList);
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
  AsyncResult<List<PostDetailDto>> listByFileType(String type) async {
    try {
      final Response response = await clientService.get(
        "${ApiBackend.post}/list/post-type/$type",
        requiresAuth: true,
      );
      final List<dynamic> resultList = response.data['posts'];
      final List<PostDetailDto> dataList = resultList
          .map((item) => PostDetailDto.fromMap(item as Map<String, dynamic>))
          .toList();
      return Success(dataList);
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
  AsyncResult<PostDetailDto> register(PostRegisterDto data, File? file) async {
    try {
      final FormData formData = FormData.fromMap({
        ...data.toMap(),
        if (file != null)
          'file': MultipartFile.fromBytes(
            await file.readAsBytes(),
            filename: file.path.split('/').last,
          ),
      });

      final Response response = await clientService.post(
        "${ApiBackend.post}/register",
        formData,
        requiresAuth: true,
        contentType: 'multipart/form-data',
      );
      final PostDetailDto postRegister = PostDetailDto.fromMap(response.data);
      return Success(postRegister);
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
  AsyncResult<PostDetailDto> update(
    String id,
    PostUpdateDto data,
    File? file,
  ) async {
    try {
      final FormData formData = FormData.fromMap({
        ...data.toMap(),
        if (file != null)
          'file': MultipartFile.fromBytes(
            await file.readAsBytes(),
            filename: file.path.split('/').last,
          ),
      });

      final Response response = await clientService.patch(
        "${ApiBackend.post}/update/$id",
        formData,
        requiresAuth: true,
        contentType: 'multipart/form-data',
      );
      final PostDetailDto postUpdate = PostDetailDto.fromMap(response.data);
      return Success(postUpdate);
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
      await clientService.delete(
        "${ApiBackend.post}/delete/$id",
        requiresAuth: true,
      );
      return Success(Unit);
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
  AsyncResult<PostDetailDto> detail(String id) async {
    try {
      final Response response = await clientService.get(
        "${ApiBackend.post}/$id",
        requiresAuth: true,
      );

      final PostDetailDto resultDetail = PostDetailDto.fromMap(response.data);
      return Success(resultDetail);
    } on DioException catch (e) {
      return Failure(
        RestException(
          message: TextConstant.errorExecutingMessage,
          statusCode: e.hashCode,
        ),
      );
    }
  }
}
