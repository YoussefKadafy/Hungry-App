import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    final errorMessage = error.response?.data['message'] ?? error.message;
    final statusCode = error.response?.statusCode;

    if (error.type == DioExceptionType.badResponse) {
      log('API Error: $statusCode - $errorMessage');
      return ApiError(message: errorMessage);
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: "Connection timeout");
      case DioExceptionType.sendTimeout:
        return ApiError(message: "Send timeout");
      case DioExceptionType.receiveTimeout:
        return ApiError(message: "Receive timeout");
      case DioExceptionType.badCertificate:
        return ApiError(message: "Bad certificate");
      case DioExceptionType.badResponse:
        return ApiError(message: "Bad response");
      case DioExceptionType.cancel:
        return ApiError(message: "Cancel");
      case DioExceptionType.connectionError:
        return ApiError(message: "Connection error");

      case DioExceptionType.unknown:
        return ApiError(message: "Unknown error");
    }
  }
}
