import 'dart:convert';

import 'package:app_posto_el/src/configs/global_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/saldo_cr/controller/saldo_status.dart';
import 'package:app_posto_el/src/pages/dashboard/saldo_cr/model/saldo_model.dart';
import 'package:app_posto_el/src/services/dio.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:mobx/mobx.dart';
part 'saldo_controller.g.dart';

class SaldoController = _SaldoControllerBase with _$SaldoController;

abstract class _SaldoControllerBase with Store {
  @observable
  ObservableList<SaldoModel> saldo = ObservableList.of([]);

  @observable
  SaldoStatus status = SaldoStatus.empty;

  @action
  Future<void> getSaldo() async {
    try {
      status = SaldoStatus.loading;

      final cnpj = UtilBrasilFields.removeCaracteres(
          GlobalSettings().appSettings.user.cnpj.substring(0, 10));

      final response = await MeuDio.dio().get('getJson/$cnpj/saldo/saldo');

      final lista = jsonDecode(response.data)
          .map<SaldoModel>((elemento) => SaldoModel.fromMap(elemento))
          .toList();

      saldo = ObservableList.of(lista);

      if (saldo.isNotEmpty) {
        status = SaldoStatus.success;
      } else {
        status = SaldoStatus.success;
      }
    } catch (e) {
      print('Eu sou erro do saldo $e');
    }
  }

  @action
  Future<ObservableList<SaldoModel>> filtro({required int local}) async {
    status = SaldoStatus.loading;

    ObservableList<SaldoModel> lista =
        ObservableList.of(saldo.where((e) => e.local == local));

    await Future.delayed(const Duration(milliseconds: 600));

    status = SaldoStatus.success;
    return lista;
  }

  @action
  Future<ObservableList<SaldoModel>> onSearchChanged(
      {required String value, required int local}) async {
    if (value.isEmpty) {
      status = SaldoStatus.loading;
    }

    ObservableList<SaldoModel> lista = ObservableList.of(saldo
        .where((saldo) =>
            (saldo.nomeCliente!.toLowerCase().contains(value.toLowerCase())) &&
            saldo.local == local)
        .toList());

    if (value.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 300));
    }

    if (value.isEmpty) {
      status = SaldoStatus.success;
    }
    return lista;
  }
}
