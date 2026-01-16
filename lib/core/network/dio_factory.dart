import 'package:dio/dio.dart';

class DioFactory {
  DioFactory._(); // Prevent direct instantiation (Singleton pattern)

  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://my-json-server.typicode.com/LeenAlkour/ebtech_task_db',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    return dio;
  }
}
