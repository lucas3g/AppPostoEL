import 'package:app_posto_el/src/configs/global_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/combustiveis/controllers/combustiveis_status.dart';
import 'package:app_posto_el/src/pages/dashboard/combustiveis/widgets/combustiveis_graficos_widget.dart';
import 'package:app_posto_el/src/pages/dashboard/widgets/loading_widget.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:app_posto_el/src/utils/formatters.dart';
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
            Wrap(
              children: [
                Observer(
                  builder: (_) {
                    final tanques = controllerCombustiveis.tanques
                        .where((tanque) =>
                            tanque.ccusto == controller.dropdownValue)
                        .toList();

                    return controllerCombustiveis.status ==
                            CombustiveisStatus.success
                        ? Wrap(
                            children: tanques
                                .map(
                                  (tanque) => CombustiveisGraficoWidget(
                                    tanque: tanque,
                                    indexTanque: tanques.indexOf(tanque),
                                  ),
                                ) // Map
                                .toList(),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LoadingWidget(
                                size: Size(160, 160),
                                radius: 80,
                              ),
                              LoadingWidget(
                                size: Size(160, 160),
                                radius: 80,
                              ),
                            ],
                          );
                  },
                ),
              ],
            ),
            Container(
              child: ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Combustível',
                        style: AppTheme.textStyles.dropdownText
                            .copyWith(fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Quantidade',
                        textAlign: TextAlign.end,
                        style: AppTheme.textStyles.dropdownText
                            .copyWith(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Observer(
              builder: (_) =>
                  controllerCombustiveis.status == CombustiveisStatus.success
                      ? Column(
                          children: (controllerCombustiveis.tanques
                              .where((local) =>
                                  local.ccusto == controller.dropdownValue)
                              .map(
                                (combustivel) => ListTile(
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          combustivel.descricao,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          combustivel.volume.Litros(),
                                          textAlign: TextAlign.end,
                                          style: AppTheme
                                              .textStyles.dropdownText
                                              .copyWith(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )).toList(),
                        )
                      : Column(
                          children: List.generate(
                            10,
                            (index) => ListTile(
                              title: Row(
                                children: [
                                  LoadingWidget(
                                    size: Size(81, 29),
                                    radius: 10,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: LoadingWidget(
                                      size: Size(81, 29),
                                      radius: 10,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: LoadingWidget(
                                      size: Size(81, 29),
                                      radius: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
