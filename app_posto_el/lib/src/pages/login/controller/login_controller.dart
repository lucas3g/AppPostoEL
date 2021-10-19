import 'dart:io';

import 'package:app_posto_el/src/configs/global_settings.dart';
import 'package:app_posto_el/src/pages/login/model/user_model.dart';
import 'package:app_posto_el/src/services/dio.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import 'login_status.dart';

export 'login_status.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  @observable
  UserModel user = UserModel();

  @action
  void onChanged({String? cnpj, String? login, String? senha}) {
    user = user.copyWith(cnpj: cnpj, login: login, senha: senha);
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

        if (!UtilBrasilFields.isCNPJValido(user.cnpj)) {
          status = LoginStatus.invalidCNPJ;
          return;
        }

        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            print('Tem Internet');
          }
        } on SocketException catch (_) {
          status = LoginStatus.semInternet;
          return;
        }

        //await Future.delayed(Duration(seconds: 2));

        final Response<dynamic> response =
            await GlobalSettings.recursiveFunction(
                function: () {
                  final response = MeuDio.dio().get(
                    '/login/${UtilBrasilFields.removeCaracteres(user.cnpj)}',
                    options: Options(
                      headers: {
                        'Login': user.login.toUpperCase(),
                        'Senha': user.senha.toUpperCase()
                      },
                    ),
                  );
                  return response;
                },
                quantity: 0,
                callback: () {
                  status = LoginStatus.error;
                  return;
                });

        final String autorizado = response.data['APP_POSTO'];

        if (autorizado == 'S') {
          await GlobalSettings().appSettings.setLogado(conectado: 'S');
          await GlobalSettings().appSettings.setUser(user: user);
          status = LoginStatus.success;
        } else {
          await GlobalSettings().appSettings.setLogado(conectado: 'N');
          status = LoginStatus.error;
        }
      } else {
        status = LoginStatus.error;
        await Future.delayed(Duration(seconds: 1));
        status = LoginStatus.empty;
      }
      // print('EU SOU RESPONSE ${autorizado}');
    } on DioError catch (e) {
      await GlobalSettings().appSettings.setLogado(conectado: 'N');
      status = LoginStatus.error;
      print('EU SOU O ERRO $e');
    }
  }
}
