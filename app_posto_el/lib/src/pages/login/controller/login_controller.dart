import 'package:app_posto_el/src/configs/app_settings.dart';
import 'package:app_posto_el/src/pages/login/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_status.dart';

export 'login_status.dart';

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

  @observable
  LoginStatus status = LoginStatus.empty;

  @observable
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @action
  Future<void> login() async {
    try {
      // if (user.cnpj.isNotEmpty &&
      //     user.login.isNotEmpty &&
      //     user.senha.isNotEmpty) {
      status = LoginStatus.loading;
      await Future.delayed(Duration(seconds: 2));
      var dio = Dio();
      // final response = await dio.get(
      //   'http://192.168.0.107:9000/login/${user.cnpj.replaceAll('.', '').replaceAll('/', '').replaceAll('-', '')}',
      //   options: Options(headers: {'Login': user.login, 'Senha': user.senha}),
      // );
      final String login = 'ADM';
      final String senha = 'EL';

      final response = await dio.get(
        'http://192.168.254.90:9000/login/01459027000100',
        options: Options(headers: {'Login': login, 'Senha': senha}),
      );
      late String autorizado = response.data['APP_POSTO'];

      if (autorizado == 'S') {
        GetIt.I.get<AppSettigns>().setLogado(conectado: 'S');
        status = LoginStatus.success;
      } else {
        GetIt.I.get<AppSettigns>().setLogado(conectado: 'N');
        status = LoginStatus.error;
      }
      // } else {
      //   status = LoginStatus.error;
      //   await Future.delayed(Duration(seconds: 1));
      //   status = LoginStatus.empty;
      // }
      //print('EU SOU RESPONSE ${autorizado}');
    } on DioError catch (e) {
      GetIt.I.get<AppSettigns>().setLogado(conectado: 'N');
      status = LoginStatus.error;
      print('EU SOU O ERRO ${e}');
    }
  }
}
