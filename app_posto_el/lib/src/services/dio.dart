import 'package:dio/dio.dart';

class MeuDio {
  static String get baseUrl => 'google.com';

  static Dio dio() {
    BaseOptions options = BaseOptions(
      baseUrl: 'http://192.168.254.69:9000',
    );

    final Dio dio = Dio(options);

    return dio;
  }
}
