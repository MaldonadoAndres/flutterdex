import 'package:dio/dio.dart';

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
    // PrettyDioLogger(
    //   request: true,
    //   requestHeader: true,
    //   responseHeader: true,
    //   responseBody: false,
    //   error: true,
    //   compact: true,
    // ),
  ]);
  return dio;
}
