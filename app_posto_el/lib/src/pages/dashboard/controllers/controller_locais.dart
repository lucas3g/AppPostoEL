import 'package:app_posto_el/src/configs/app_settings.dart';
import 'package:app_posto_el/src/configs/global_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/controllers/locais_status.dart';
import 'package:app_posto_el/src/pages/dashboard/models/model_locais.dart';
import 'package:app_posto_el/src/pages/login/controller/login_controller.dart';

import 'package:dio/dio.dart';
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

      var dio = Dio();
      final String cnpj = GlobalSettings().appSettings.cnpj['cnpj']!;

      final response =
          await dio.get('http://192.168.254.90:9000/empresa/$cnpj');

      final lista = response.data
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
      print('EU SOU O ERRO $e');
    }
  }
}
