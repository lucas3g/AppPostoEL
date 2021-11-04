import 'package:dio/dio.dart';

class MeuDio {
  static String get baseUrl => 'google.com';

  static Dio dio() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://elinfo2.jelastic.saveincloud.net/AppPostoPlus/',
    );

    final Dio dio = Dio(options);

    return dio;
  }
}
