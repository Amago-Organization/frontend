
import 'package:pulse_post/app/core/utils/envied/env.dart';

final class ApiBackend {
  static final String baseUrl = Env.baseUrl;
  static final String user = "$baseUrl/user";
  static final String post = "$baseUrl/post";
}
