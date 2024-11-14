import 'package:dio/dio.dart';

final class AuthorInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final headers = options.headers;

    const authorHeader = "author";

    headers[authorHeader] = "israel-oliveira + israeloliveira.dev@gmail.com";

    handler.next(options);
  }
}
