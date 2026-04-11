import 'package:pulse_post/app/features/domain/remocao/dtos/user/user_token_dto.dart';

abstract interface class LocalStorageServiceFack {
  Future<String?> get(String key);
  Future<void> put(String key, UserTokenDto value);
  Future<void> delete(String key);
}
