// auth_interceptor.dart
import 'package:dio/dio.dart';
import 'package:amago/app/core/services/local/local_storage_service.dart';
import 'package:amago/app/core/utils/constants/local/local_storage_constant.dart';

final class AuthInterceptor extends InterceptorsWrapper {
  final LocalStorageService localStorageService;
  final Dio dio;
  AuthInterceptor({required this.localStorageService, required this.dio});

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra['requiredAuth'] == true) {
      final accessToken = await localStorageService.get(
        LocalStorageConstant.token,
      );

      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }

    return handler.next(options);
  }
}
