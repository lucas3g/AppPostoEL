import 'package:app_posto_el/src/configs/global_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/widgets/controller/limpa_dados_status.dart';
import 'package:mobx/mobx.dart';
part 'limpa_dados_controller.g.dart';

class LimpaDadosController = _LimpaDadosControllerBase
    with _$LimpaDadosController;

abstract class _LimpaDadosControllerBase with Store {
  final controllerVendas = GlobalSettings().controllerVendas;
  final controllerLocais = GlobalSettings().controllerLocais;
  final controllerTanques = GlobalSettings().controllerCombustiveis;

  @observable
  LimpaDadosStatus status = LimpaDadosStatus.empty;

  @action
  limpaDados() {
    status = LimpaDadosStatus.loading;
    controllerVendas.limpaDadosVendas();
    controllerTanques.limpaDadosTanques();
    controllerLocais.limpaDadosLocais();
    status = LimpaDadosStatus.success;
  }
}
