import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio createDio() {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      responseType: ResponseType.json,
    ),
  );

  dio.interceptors.addAll([
    // LogInterceptor(requestBody: true, responseBody: true),
    PrettyDioLogger(
      request: true,
      requestHeader: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      compact: true,
    ),
  ]);
  return dio;
}
