import 'package:dio/dio.dart';

class CacheInterceptor extends Interceptor {
  final Map<String, Response> _cache = {};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_cache.containsKey(options.uri.toString())) {
      handler.resolve(_cache[options.uri.toString()]!);
      return;
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _cache[response.requestOptions.uri.toString()] = response;
    handler.next(response);
  }
}
