import 'package:app_posto_el/src/configs/global_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/vendas/controllers/vendas/vendas_status.dart';
import 'package:app_posto_el/src/pages/dashboard/vendas/models/vendas_model.dart';
import 'package:app_posto_el/src/services/dio.dart';
import 'package:app_posto_el/src/utils/formatters.dart';
import 'package:brasil_fields/brasil_fields.dart';
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

      final cnpj = UtilBrasilFields.removeCaracteres(
          await GlobalSettings().appSettings.user.cnpj);

      final response = await MeuDio.dio().get('/vendas/valor/$cnpj');

      final lista = response.data
          .map<VendasModel>((elemento) => VendasModel.fromMap(elemento))
          .toList();

      final responseVolumes = await MeuDio.dio().get('/vendas/volume/$cnpj');

      final listaVolumes = responseVolumes.data
          .map<VendasModel>((elemento) => VendasModel.fromMap(elemento))
          .toList();

      final ObservableList<VendasModel> listaNova = ObservableList.of([]);

      for (var venda in lista) {
        for (var volume in listaVolumes) {
          if (venda.ID == volume.ID && venda.DATA == volume.DATA) {
            listaNova.add(venda.copyWith(QTD_TOTAL: volume.QTD_TOTAL));
          }
        }
      }

      vendas = ObservableList.of(listaNova);

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

  @action
  String somaLitros({required int local}) {
    var inicio = DateTime.now().subtract(Duration(days: 7));

    final double result = vendas
        .where((volume) =>
            !DateTime.parse(volume.DATA.toString()).isBefore(inicio) &&
            volume.ID == local)
        .map((volume) => volume.QTD_TOTAL)
        .reduce((value, element) => value + element);
    return result.Litros();
  }

  @action
  String projecaoLitros({required int local}) {
    final double total = vendas
        .where((volume) => volume.ID == local)
        .map((volume) => volume.QTD_TOTAL)
        .reduce((value, element) => value + element);
    final dias = DateTime.now();

    final double mediaDiaria =
        total / dias.difference(DateTime(dias.year, dias.month, 0)).inDays;

    final result = mediaDiaria * (DateTime(dias.year, dias.month + 1, 0).day);

    return result.Litros();
  }
}
