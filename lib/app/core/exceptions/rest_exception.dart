// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

class RestException implements Exception {
  final String message;
  final int statusCode;
  final Response? response;
  RestException({
    required this.message,
    required this.statusCode,
    this.response,
  });

  @override
  String toString() => 'RestException(message: $message, statusCode: $statusCode, response: $response)';
}