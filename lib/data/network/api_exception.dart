import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  factory ApiException.fromDio(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return ApiException('Connection timeout');
    }

    if (e.type == DioExceptionType.connectionError) {
      return ApiException('No internet connection');
    }
    return ApiException(
      e.response?.data['error']?['message'] ?? 'Unexpected API error',
    );
  }

  @override
  String toString() => message;
}
