import 'package:dio/dio.dart';

class MeuDio {
  BaseOptions options = new BaseOptions(
    baseUrl: 'http://192.168.254.90:9000',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  late Dio dio = Dio(options);
}
