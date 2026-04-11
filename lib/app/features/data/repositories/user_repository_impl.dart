// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:pulse_post/app/core/exceptions/rest_exception.dart';
import 'package:pulse_post/app/core/utils/constants/texts/text_constant.dart';
import 'package:pulse_post/app/features/data/datasources/user/user_datasource.dart';
import 'package:result_dart/result_dart.dart';

import 'package:pulse_post/app/features/domain/entities/user_entity.dart';
import 'package:pulse_post/app/features/domain/params/users/user_login_param.dart';
import 'package:pulse_post/app/features/domain/params/users/user_register_param.dart';
import 'package:pulse_post/app/features/domain/params/users/user_update_param.dart';
import 'package:pulse_post/app/features/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource datasource;
  UserRepositoryImpl({required this.datasource});

  @override
  AsyncResult<UserEntity> detail() async {
    try {
      final result = await datasource.detail();
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
  AsyncResult<String> login(UserLoginParam data) async {
    try {
      final result = await datasource.login(data);
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
  AsyncResult<UserEntity> register(UserRegisterParam data) async {
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
  AsyncResult<UserEntity> update(UserUpdateParam data) async {
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
