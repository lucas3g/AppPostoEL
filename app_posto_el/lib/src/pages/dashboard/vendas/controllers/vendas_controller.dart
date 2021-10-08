import 'package:app_posto_el/src/configs/global_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/vendas/controllers/vendas_status.dart';
import 'package:app_posto_el/src/pages/dashboard/vendas/models/vendas_model.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
part 'vendas_controller.g.dart';

class VendasController = _VendasControllerBase with _$VendasController;

abstract class _VendasControllerBase with Store {
  @observable
  ObservableList<VendasModel> vendas = ObservableList.of([]);

  @observable
  VendasStatus status = VendasStatus.empty;

  @action
  Future<void> getVendas() async {
    try {
      status = VendasStatus.loading;

      var dio = Dio();
      final cnpj = GlobalSettings().appSettings.cnpj['cnpj'];

      final response = await dio.get('http://192.168.254.90:9000/vendas/$cnpj');

      final lista = response.data
          .map<VendasModel>((elemento) => VendasModel.fromMap(elemento))
          .toList();

      vendas = ObservableList.of(lista);

      if (vendas.isNotEmpty) {
        status = VendasStatus.success;
      } else {
        status = VendasStatus.success;
      }
    } catch (e) {
      status = VendasStatus.error;
      print('EU SOU O ERRO $e');
    }
  }
}
