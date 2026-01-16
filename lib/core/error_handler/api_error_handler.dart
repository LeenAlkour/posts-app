import 'package:dio/dio.dart';
import 'failure.dart';

class ApiErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return const NetworkFailure();
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          return const TimeoutFailure();
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode ?? 500;
          final message = error.response?.data?['message'] ?? 'Server Error';
          return ServerFailure('[$statusCode] $message');
        default:
          return UnexpectedFailure(error.message ?? 'Unexpected error');
      }
    } else {
      return UnexpectedFailure(error.toString());
    }
  }
}
