import 'package:app_posto_el/src/configs/global_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/vendas/controllers/volumes/volumes_status.dart';
import 'package:app_posto_el/src/pages/dashboard/vendas/models/volumes_model.dart';
import 'package:app_posto_el/src/utils/formatters.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
part 'volumes_controller.g.dart';

class VolumesController = _VolumesControllerBase with _$VolumesController;

abstract class _VolumesControllerBase with Store {
  @observable
  ObservableList<VolumesModel> volumes = ObservableList.of([]);

  @observable
  VolumesStatus status = VolumesStatus.empty;

  @action
  Future<void> getLitros() async {
    try {
      status = VolumesStatus.loading;

      var dio = Dio();
      final cnpj = await GlobalSettings().appSettings.cnpj['cnpj'];

      final response =
          await dio.get('http://192.168.254.69:9000/vendas/volume/$cnpj');

      final lista = response.data
          .map<VolumesModel>((elemento) => VolumesModel.fromMap(elemento))
          .toList();

      volumes = ObservableList.of(lista);

      if (volumes.isNotEmpty) {
        status = VolumesStatus.success;
      } else {
        status = VolumesStatus.success;
      }
    } catch (e) {
      status = VolumesStatus.error;
      print('EU SOU O ERRO $e');
    }
  }

  @action
  String somaLitros({required int local}) {
    var inicio = DateTime.now().subtract(Duration(days: 7));

    final double result = volumes
        .where((volume) =>
            !DateTime.parse(volume.DATA.toString()).isBefore(inicio) &&
            volume.ID == local)
        .map((volume) => volume.QTD_TOTAL)
        .reduce((value, element) => value + element);
    return result.Litros();
  }

  @action
  String projecaoLitros({required int local}) {
    final double total = volumes
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
