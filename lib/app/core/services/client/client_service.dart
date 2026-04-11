import 'package:dio/dio.dart';

abstract interface class ClientService {
  Future get(
    String uri, {
    bool requiresAuth,
    String contentType,
    ResponseType? responseType,
    Map<String, dynamic>? headers,
  });
  Future post(String uri, Object value,
      {bool requiresAuth, String contentType});
  Future put(String uri,  Object? value, {bool requiresAuth, String contentType});
  Future patch(String uri,  Object? value, {bool requiresAuth, String contentType});
  Future delete(String uri, {bool requiresAuth, String contentType});
}
