import 'dart:io';

import 'package:app_posto_el/src/configs/global_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/combustiveis/controllers/combustiveis_status.dart';
import 'package:app_posto_el/src/pages/dashboard/combustiveis/models/combustiveis_model.dart';
import 'package:app_posto_el/src/services/dio.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:mobx/mobx.dart';
part 'combustiveis_controller.g.dart';

class CombustiveisController = _CombustiveisControllerBase
    with _$CombustiveisController;

abstract class _CombustiveisControllerBase with Store {
  @observable
  ObservableList<CombustiveisModel> tanques = ObservableList.of([]);

  @observable
  CombustiveisStatus status = CombustiveisStatus.empty;

  @action
  Future<void> getTanques() async {
    try {
      status = CombustiveisStatus.loading;

      try {
        final result = await InternetAddress.lookup(MeuDio.baseUrl);
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('Tem Internet');
        }
      } on SocketException catch (_) {
        print('Sem Internet Combustiveis');
        status = CombustiveisStatus.falhaServidor;
        return;
      }

      final cnpj = UtilBrasilFields.removeCaracteres(
          GlobalSettings().appSettings.user.cnpj);

      final response = await MeuDio.dio().get('/vendas/tanques/$cnpj');

      final lista = response.data
          .map<CombustiveisModel>(
              (elemento) => CombustiveisModel.fromMap(elemento))
          .toList();

      tanques = ObservableList.of(lista);

      if (tanques.isNotEmpty) {
        status = CombustiveisStatus.success;
      } else {
        status = CombustiveisStatus.success;
      }
    } catch (e) {
      status = CombustiveisStatus.error;
      print('EU SOU O ERRO $e');
    }
  }
}
