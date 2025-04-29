import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final Duration retryDelay;

  RetryInterceptor(
      {required this.dio,
      this.maxRetries = 3,
      this.retryDelay = const Duration(seconds: 2)});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err) && maxRetries > 0) {
      for (int i = 0; i < maxRetries; i++) {
        await Future.delayed(retryDelay);
        try {
          final response = await dio.fetch(err.requestOptions);
          return handler.resolve(response);
        } catch (_) {
          continue;
        }
      }
    }
    handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        (err.response != null && err.response!.statusCode! >= 500);
  }
}
