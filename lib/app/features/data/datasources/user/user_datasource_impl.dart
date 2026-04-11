// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:pulse_post/app/core/services/client/client_service.dart';
import 'package:pulse_post/app/core/utils/apis/api_backend.dart';
import 'package:pulse_post/app/features/data/mappers/user_mapper.dart';
import 'package:pulse_post/app/features/data/models/user_model.dart';
import 'package:pulse_post/app/features/domain/params/users/user_login_param.dart';
import 'package:pulse_post/app/features/domain/params/users/user_register_param.dart';
import 'package:pulse_post/app/features/domain/params/users/user_update_param.dart';

import 'user_datasource.dart';

class UserDatasourceImpl implements UserDatasource {
  final ClientService clientService;
  UserDatasourceImpl({required this.clientService});

  @override
  Future<UserModel> detail() async {
    final Response response = await clientService.get(
      "${ApiBackend.user}/detail",
      requiresAuth: true,
    );
    return UserModel.fromMap(response.data);
  }

  @override
  Future<String> login(UserLoginParam data) async {
    final Response response = await clientService.post(
      "${ApiBackend.user}/login",
      data.toMap(),
    );
    return response.data['token'];
  }

  @override
  Future<UserModel> register(UserRegisterParam data) async {
    final Response response = await clientService.post(
      "${ApiBackend.user}/register",
      data.toMap(),
    );
    return UserModel.fromMap(response.data);
  }

  @override
  Future<UserModel> update(UserUpdateParam data) async {
    final FormData formData = FormData.fromMap({
      ...data.toMap(),
      if (data.file != null)
        'image': MultipartFile.fromBytes(
          await data.file!.readAsBytes(),
          filename: data.file!.path.split('/').last,
        ),
    });

    final Response response = await clientService.patch(
      "${ApiBackend.user}/update",
      formData,
      requiresAuth: true,
      contentType: 'multipart/form-data',
    );

    return UserModel.fromMap(response.data);
  }
}
