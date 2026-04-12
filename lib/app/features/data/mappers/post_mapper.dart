import 'package:amago/app/features/domain/params/posts/post_register_param.dart';
import 'package:amago/app/features/domain/params/posts/post_update_param.dart';

extension PostRegisterParamMapper on PostRegisterParam {
  Map<String, dynamic> toMap() => {'title': title, 'description': description};
}

extension PostUpdateParamMapper on PostUpdateParam {
  Map<String, dynamic> toMap() => {'title': title, 'description': description};
}
