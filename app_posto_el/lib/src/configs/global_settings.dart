import 'package:app_posto_el/src/configs/app_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/combustiveis/controllers/combustiveis_controller.dart';
import 'package:app_posto_el/src/pages/dashboard/controllers/controller_locais.dart';
import 'package:app_posto_el/src/pages/dashboard/vendas/controllers/vendas/vendas_controller.dart';
import 'package:get_it/get_it.dart';

class GlobalSettings {
  final appSettings = GetIt.I.get<AppSettigns>();
  final controllerLocais = GetIt.I.get<ControllerLocais>();
  final controllerVendas = GetIt.I.get<VendasController>();
  final controllerCombustiveis = GetIt.I.get<CombustiveisController>();

  static recursiveFunction(
      {required Function function,
      required int quantity,
      required Function? callback}) async {
    try {
      return await function();
    } catch (err) {
      if (quantity == 3) {
        if (callback != null) {
          return await callback();
        }
        return;
      } else {
        quantity++;
        return Future.delayed(Duration(milliseconds: 200)).then((value) async {
          return await recursiveFunction(
              function: function, quantity: quantity, callback: callback);
        });
      }
    }
  }
}
