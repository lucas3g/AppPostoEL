import 'package:app_posto_el/src/pages/login/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  @observable
  UserModel user = UserModel(cnpj: '', login: '', senha: '');

  @action
  void onChanged({String? cnpj, String? login, String? senha}) {
    user = user.copyWith(cnpj: cnpj, login: login, senha: senha);
    print(user);
  }

  final dio = Dio();

  @action
  Future<void> login() async {
    try {
      final response = await dio.get('192.168.0.107:9000/login/01459027000100',
          //'192.168.0.107:9000/login/${user.cnpj.replaceAll('.', '').replaceAll('/', '').replaceAll('-', '')}',
          options:
              Options(headers: {'Login': user.login, 'Senha': user.senha}));
      print(response);
    } on DioError catch (e) {
      print(e.response?.headers);
    }
  }
}
