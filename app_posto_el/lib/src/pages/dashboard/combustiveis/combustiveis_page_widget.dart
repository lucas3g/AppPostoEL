import 'package:app_posto_el/src/configs/global_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/combustiveis/controllers/combustiveis_status.dart';
import 'package:app_posto_el/src/pages/dashboard/combustiveis/widgets/combustiveis_graficos_widget.dart';
import 'package:app_posto_el/src/pages/dashboard/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CombustiveisPageWidget extends StatefulWidget {
  const CombustiveisPageWidget({Key? key}) : super(key: key);

  @override
  State<CombustiveisPageWidget> createState() => _CombustiveisPageWidgetState();
}

class _CombustiveisPageWidgetState extends State<CombustiveisPageWidget> {
  final controller = GlobalSettings().controllerLocais;
  final controllerCombustiveis = GlobalSettings().controllerCombustiveis;

  void getTanques() async {
    if (controllerCombustiveis.tanques.isEmpty) {
      await controllerCombustiveis.getTanques();
    }
  }

  @override
  void initState() {
    getTanques();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Observer(
                  builder: (_) {
                    final tanques = controllerCombustiveis.tanques
                        .where((tanque) =>
                            tanque.CCUSTO == controller.dropdownValue)
                        .toList();

                    return controllerCombustiveis.status ==
                            CombustiveisStatus.success
                        ? Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: tanques
                                    .where((tanque) =>
                                        tanque.CCUSTO ==
                                        controller.dropdownValue)
                                    .map(
                                      (tanque) => CombustiveisGraficoWidget(
                                        tanque: tanque,
                                        indexTanque: tanques.indexOf(tanque),
                                      ),
                                    ) // Map
                                    .toList(),
                              ),
                            ],
                          )
                        : LoadingWidget(
                            size: Size(160, 160),
                          );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
