import 'dart:convert';
import 'dart:io';

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

      try {
        final result = await InternetAddress.lookup(MeuDio.baseUrl);
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
      } on SocketException catch (_) {
        status = VendasStatus.falhaServidor;
        return;
      }

      final cnpj = UtilBrasilFields.removeCaracteres(
          GlobalSettings().appSettings.user.cnpj.substring(0, 10));

      final response = await MeuDio.dio().get('getJson/$cnpj/vendas/vendas');

      final lista = jsonDecode(response.data)
          .map<VendasModel>((elemento) => VendasModel.fromMap(elemento))
          .toList();

      final responseVolumes =
          await MeuDio.dio().get('getJson/$cnpj/vendas/volume');

      final listaVolumes = jsonDecode(responseVolumes.data)
          .map<VendasModel>((elemento) => VendasModel.fromMap(elemento))
          .toList();

      final ObservableList<VendasModel> listaNova = ObservableList.of([]);

      for (var venda in lista) {
        for (var volume in listaVolumes) {
          if (venda.local == volume.local && venda.data == volume.data) {
            listaNova.add(venda.copyWith(qtdTotal: volume.qtdTotal));
          }
        }
      }

      vendas = ObservableList.of(listaNova);

      await Future.delayed(const Duration(milliseconds: 300));

      if (vendas.isNotEmpty) {
        status = VendasStatus.success;
      } else {
        status = VendasStatus.success;
      }
    } catch (e) {
      status = VendasStatus.error;
      print('EU SOU O ERRO DAS VENDAS $e');
    }
  }

  @action
  String somaVendas({required int local}) {
    late double result;

    var inicio = DateTime.now().subtract(const Duration(days: 7));

    result = vendas
        .where((venda) =>
            !DateTime.parse(venda.data.toString()).isBefore(inicio) &&
            venda.local == local)
        .map((venda) => venda.vlrTotal)
        .reduce((value, element) => value + element);
    return result.reais();
  }

  @action
  String projecaoVenda({required int local}) {
    final double total = vendas
        .where((venda) => venda.local == local)
        .map((venda) => venda.vlrTotal)
        .reduce((value, element) => value + element);
    final dias = DateTime.now();

    final double mediaDiaria =
        total / dias.difference(DateTime(dias.year, dias.month, 0)).inDays;

    final result = mediaDiaria * (DateTime(dias.year, dias.month + 1, 0).day);

    return result.reais();
  }

  @action
  String somaLitros({required int local}) {
    var inicio = DateTime.now().subtract(const Duration(days: 7));

    final double result = vendas
        .where((venda) =>
            !DateTime.parse(venda.data.toString()).isBefore(inicio) &&
            venda.local == local)
        .map((venda) => venda.qtdTotal)
        .reduce((value, element) => value + element);
    return result.Litros();
  }

  @action
  String projecaoLitros({required int local}) {
    final double total = vendas
        .where((venda) => venda.local == local)
        .map((venda) => venda.qtdTotal)
        .reduce((value, element) => value + element);
    final dias = DateTime.now();

    final double mediaDiaria =
        total / dias.difference(DateTime(dias.year, dias.month, 0)).inDays;

    final result = mediaDiaria * (DateTime(dias.year, dias.month + 1, 0).day);

    return result.Litros();
  }

  @action
  limpaDadosVendas() {
    status = VendasStatus.loading;
    vendas.clear();
  }
}
