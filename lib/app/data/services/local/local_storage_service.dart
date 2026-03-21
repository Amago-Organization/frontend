import 'package:pulse_post/app/domain/dtos/user/user_token_dto.dart';

abstract interface class LocalStorageService {
  Future<String?> get(String key);
  Future<void> put(String key, UserTokenDto value);
  Future<void> delete(String key);
}
