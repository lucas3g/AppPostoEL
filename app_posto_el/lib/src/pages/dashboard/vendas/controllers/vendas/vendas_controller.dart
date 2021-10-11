import 'package:app_posto_el/src/configs/global_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/vendas/controllers/vendas/vendas_status.dart';
import 'package:app_posto_el/src/pages/dashboard/vendas/models/vendas_model.dart';
import 'package:app_posto_el/src/pages/dashboard/vendas/models/volumes_model.dart';
import 'package:app_posto_el/src/utils/formatters.dart';
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

      final response =
          await dio.get('http://192.168.254.69:9000/vendas/Valor/$cnpj');

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

  @action
  String somaVendas({required int local}) {
    var inicio = DateTime.now().subtract(Duration(days: 7));

    final double result = vendas
        .where((venda) =>
            !DateTime.parse(venda.DATA.toString()).isBefore(inicio) &&
            venda.ID == local)
        .map((venda) => venda.VLR_TOTAL)
        .reduce((value, element) => value + element);
    return result.reais();
  }

  @action
  String projecaoVenda({required int local}) {
    final double total = vendas
        .where((venda) => venda.ID == local)
        .map((venda) => venda.VLR_TOTAL)
        .reduce((value, element) => value + element);
    final dias = DateTime.now();

    final double mediaDiaria =
        total / dias.difference(DateTime(dias.year, dias.month, 0)).inDays;

    final result = mediaDiaria * (DateTime(dias.year, dias.month + 1, 0).day);

    return result.reais();
  }
}
