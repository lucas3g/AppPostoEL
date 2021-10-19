import 'package:dio/dio.dart';

class MeuDio {
  static Dio dio() {
    BaseOptions options = BaseOptions(
      baseUrl: 'http://192.168.0.107:9000',
    );

    final Dio dio = Dio(options);

    return dio;
  }
}
