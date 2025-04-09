import 'dart:developer';

import 'package:dio/dio.dart';

class ErrorLoggingInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log("❌ API Error: ${err.message}");
    if (err.response != null) {
      log("🔴 Error Code: ${err.response!.statusCode}");
      log("🔴 Error Details: ${err.response!.data}");
    }
    handler.next(err);
  }
}
