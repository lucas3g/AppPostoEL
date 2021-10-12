import 'package:app_posto_el/src/configs/app_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/combustiveis/controllers/combustiveis_controller.dart';
import 'package:app_posto_el/src/pages/dashboard/controllers/controller_locais.dart';
import 'package:app_posto_el/src/pages/dashboard/vendas/controllers/vendas/vendas_controller.dart';
import 'package:app_posto_el/src/pages/dashboard/vendas/controllers/volumes/volumes_controller.dart';
import 'package:app_posto_el/src/pages/login/model/user_model.dart';
import 'package:get_it/get_it.dart';

class GlobalSettings {
  final appSettings = GetIt.I.get<AppSettigns>();
  final userSettings = GetIt.I.get<UserModel>();
  final controllerLocais = GetIt.I.get<ControllerLocais>();
  final controllerVendas = GetIt.I.get<VendasController>();
  final controllerVolumes = GetIt.I.get<VolumesController>();
  final controllerCombustiveis = GetIt.I.get<CombustiveisController>();
}
