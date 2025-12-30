import 'package:hungry/core/errors/failure.dart';

class ApiError extends Failure {
  final String message;
  final String? code;
  ApiError({required this.message, this.code});
  @override
  String toString() {
    return message;
  }
}
