// Class -> AppException
import 'package:dio/dio.dart';

/// An exception thrown by the application.
class AppException implements Exception {
  // Constructor -> AppException
  /// Creates an instance of [AppException] with the given [message].
  AppException(this.message);

  // Method -> fromDioError
  /// Creates an instance of [AppException] from a [DioException].
  factory AppException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionError:
        return AppException('Connection error');
      case DioExceptionType.connectionTimeout:
        return AppException('Connection timeout');
      case DioExceptionType.sendTimeout:
        return AppException('Send timeout');
      case DioExceptionType.receiveTimeout:
        return AppException('Receive timeout');
      case DioExceptionType.badResponse:
        return AppException('Response error');
      case DioExceptionType.badCertificate:
        return AppException('Bad certificate');
      case DioExceptionType.cancel:
        return AppException('Request cancelled');
      case DioExceptionType.unknown:
        return AppException('Unknown error');
    }
  }

  // Attribute -> message
  /// The message associated with the exception.
  final String message;
}
