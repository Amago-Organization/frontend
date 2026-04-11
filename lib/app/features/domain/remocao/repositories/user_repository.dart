import 'dart:io';

import 'package:pulse_post/app/features/domain/remocao/dtos/user/user_detail_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/user/user_login_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/user/user_register_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/user/user_token_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/user/user_update_dto.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class UserRepository {
  AsyncResult<UserDetailDto> register(UserRegisterDto data);
  AsyncResult<UserTokenDto> login(UserLoginDto data);
  AsyncResult<UserDetailDto> detail();
  AsyncResult<UserDetailDto> update(UserUpdateDto data, File? file);
}
