class ApiErrorModel {
  final String message;
  final int? statusCode;

  ApiErrorModel({required this.message, this.statusCode});

  @override
  String toString() {
    return 'ApiError: $message (Status code: $statusCode)';
  }
}
