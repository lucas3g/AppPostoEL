import 'dart:convert';
import 'dart:io';

import 'package:app_posto_el/src/configs/global_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/controllers/locais_status.dart';
import 'package:app_posto_el/src/pages/dashboard/models/model_locais.dart';
import 'package:app_posto_el/src/pages/login/controller/login_controller.dart';
import 'package:app_posto_el/src/services/dio.dart';
import 'package:brasil_fields/brasil_fields.dart';

import 'package:mobx/mobx.dart';

part 'controller_locais.g.dart';

class ControllerLocais = _ControllerLocaisBase with _$ControllerLocais;
final controllerLogin = LoginController();

abstract class _ControllerLocaisBase with Store {
  @observable
  ObservableList<ModelLocais> locais = ObservableList.of([]);

  @observable
  int dropdownValue = 0;

  @observable
  LocaisStatus status = LocaisStatus.empty;

  @action
  Future<void> getLocais() async {
    try {
      status = LocaisStatus.loading;

      try {
        final result = await InternetAddress.lookup(MeuDio.baseUrl);
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('Tem Internet');
        }
      } on SocketException catch (_) {
        print('Sem Internet Locais');
        status = LocaisStatus.falhaServidor;
        return;
      }

      String cnpj = UtilBrasilFields.removeCaracteres(
          GlobalSettings().appSettings.user.cnpj.substring(0, 10));

      final response = await MeuDio.dio().get('getJson/$cnpj/locais/locais');

      final lista = jsonDecode(response.data)
          .map<ModelLocais>((elemento) => ModelLocais.fromMap(elemento))
          .toList();

      locais = ObservableList.of(lista);

      if (locais.isNotEmpty) {
        status = LocaisStatus.success;
      } else {
        status = LocaisStatus.error;
      }
    } catch (e) {
      status = LocaisStatus.error;
      print('EU SOU O ERRO LOCAIS $e');
    }
  }
}
