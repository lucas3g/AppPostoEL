import 'package:app_posto_el/src/configs/global_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/combustiveis/controllers/combustiveis_status.dart';
import 'package:app_posto_el/src/pages/dashboard/combustiveis/models/combustiveis_model.dart';
import 'package:app_posto_el/src/pages/dashboard/combustiveis/widgets/combustiveis_graficos_widget.dart';
import 'package:app_posto_el/src/pages/dashboard/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CombustiveisPageWidget extends StatefulWidget {
  const CombustiveisPageWidget({Key? key}) : super(key: key);

  @override
  State<CombustiveisPageWidget> createState() => _CombustiveisPageWidgetState();
}

class _CombustiveisPageWidgetState extends State<CombustiveisPageWidget> {
  final controller = GlobalSettings().controllerLocais;
  final controllerCombustiveis = GlobalSettings().controllerCombustiveis;
  final List<Color> colors = [
    Color(0xFFFF7F26),
    Color(0xFFC627F8),
    Color(0xFFAB0155),
    Color(0xFF2A2F3B),
    Color(0xFF18BCF4),
    Color(0xFF07311D),
    Color(0xFFAB414D),
  ];

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
                            tanque.CCUSTO == controller.dropdownValue)
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
          ],
        ),
      ),
    );
  }

  /// Returns the doughnut series which need to be center elevation.
  List<DoughnutSeries<TanqueData, String>> getSeriesTanques(
      {required CombustiveisModel tanque, required int index}) {
    final List<TanqueData> chartData = [
      TanqueData(
          x: 'A',
          y: tanque.VOLUME.toDouble(),
          pointColor: index < colors.length ? colors[index] : colors[0]),
      TanqueData(
          x: 'B',
          y: tanque.VOLUME.toDouble() > tanque.CAPACIDADE.toDouble()
              ? 0
              : tanque.CAPACIDADE.toDouble() - tanque.VOLUME.toDouble(),
          pointColor: Color.fromRGBO(230, 230, 230, 1))
    ];

    return <DoughnutSeries<TanqueData, String>>[
      DoughnutSeries<TanqueData, String>(
        dataSource: chartData,
        animationDuration: 700,
        xValueMapper: (TanqueData data, _) => data.x,
        yValueMapper: (TanqueData data, _) => data.y,
        pointColorMapper: (TanqueData data, _) => data.pointColor,
      )
    ];
  }
}

class TanqueData {
  TanqueData({required this.x, required this.y, required this.pointColor});
  final String x;
  final double y;
  final Color pointColor;
}
