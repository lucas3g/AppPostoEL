import 'package:app_posto_el/src/configs/global_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/combustiveis/controllers/combustiveis_status.dart';
import 'package:app_posto_el/src/pages/dashboard/combustiveis/models/combustiveis_model.dart';
import 'package:dio/dio.dart';
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

      var dio = Dio();
      final cnpj = await GlobalSettings().appSettings.cnpj['cnpj'];

      final response =
          await dio.get('http://192.168.0.107:9000/vendas/tanques/$cnpj');

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
