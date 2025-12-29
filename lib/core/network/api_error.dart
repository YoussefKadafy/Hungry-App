class ApiError {
  final String message;
  final String? code;
  ApiError({required this.message, this.code});
  @override
  String toString() {
    return ' $message';
  }
}
