import 'package:amago/app/features/domain/params/users/user_login_param.dart';
import 'package:amago/app/features/domain/params/users/user_register_param.dart';
import 'package:amago/app/features/domain/params/users/user_update_param.dart';

extension UserLoginParamMapper on UserLoginParam {
  Map<String, dynamic> toMap() => {'email': email, 'password': password};
}

extension UserRegisterParamMapper on UserRegisterParam {
  Map<String, dynamic> toMap() => {
    'name': name,
    'email': email,
    'password': password,
  };
}

extension UserUpdateParamMapper on UserUpdateParam {
  Map<String, dynamic> toMap() => {'name': name, 'bio': bio};
}
