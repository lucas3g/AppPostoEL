import 'package:app_posto_el/src/pages/login/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

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

  @action
  Future<void> login() async {
    try {
      if (user.cnpj.isNotEmpty &&
          user.login.isNotEmpty &&
          user.senha.isNotEmpty) {
        status = LoginStatus.loading;
        await Future.delayed(Duration(seconds: 2));
        var dio = Dio();
        final response = await dio.get(
          'http://192.168.0.107:9000/login/${user.cnpj.replaceAll('.', '').replaceAll('/', '').replaceAll('-', '')}',
          options: Options(headers: {'Login': user.login, 'Senha': user.senha}),
        );
        late String autorizado = response.data['appPosto'];

        if (autorizado == 'S') {
          status = LoginStatus.success;
        } else {
          status = LoginStatus.error;
        }
      } else {
        status = LoginStatus.error;
        await Future.delayed(Duration(seconds: 1));
        status = LoginStatus.empty;
      }
      //print('EU SOU RESPONSE ${autorizado}');
    } on DioError catch (e) {
      status = LoginStatus.error;
      print('EU SOU O ERRO ${e}');
    }
  }
}
