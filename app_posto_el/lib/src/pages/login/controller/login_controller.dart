import 'package:app_posto_el/src/pages/login/model/user_model.dart';
import 'package:dio/dio.dart';

class LoginController {
  void addUser({required String cnpj, required String senha}) {
    UserModel(cnpj: cnpj, senha: senha);
  }

  void login({required String cnpj, required String senha}) async {
    var dio = Dio();
    final response = await dio.get(
        '192.168.254.90:9000/login/${cnpj.replaceAll('.', '').replaceAll('/', '')}',
        options: Options(headers: {'Login': 'ADM', 'Senha': senha}));
    print(response);
  }
}
