import 'package:app_posto_el/src/configs/global_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/combustiveis/controllers/combustiveis_status.dart';
import 'package:app_posto_el/src/pages/dashboard/widgets/loading_widget.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:app_posto_el/src/utils/formatters.dart';
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
  late List<TanquesData> listaNovaA = [];
  late List<TanquesData> listaNovaB = [];

  void getTanques() async {
    if (controllerCombustiveis.tanques.isEmpty) {
      await controllerCombustiveis.getTanques();
      montaGrafico();
    }
  }

  montaGrafico() {
    listaNovaA = controllerCombustiveis.tanques
        .where((tanque) => tanque.CCUSTO == controller.dropdownValue)
        .map((tanque) => TanquesData('A', tanque.CAPACIDADE - tanque.VOLUME,
            Color.fromRGBO(0, 220, 252, 1)))
        .toList();

    listaNovaB = controllerCombustiveis.tanques
        .where((tanque) => tanque.CCUSTO == controller.dropdownValue)
        .map((tanque) => TanquesData('B', tanque.CAPACIDADE.toDouble(),
            Color.fromRGBO(230, 230, 230, 1)))
        .toList();

    listaNovaA.addAll(listaNovaB);

    return listaNovaA;
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
                  builder: (_) => controllerCombustiveis.status ==
                          CombustiveisStatus.success
                      ? Column(
                          children: controllerCombustiveis.tanques
                              .where((tanque) =>
                                  tanque.CCUSTO == controller.dropdownValue)
                              .map(
                                (tanque) => Column(
                                  children: [
                                    Text('TANQUE ${tanque.TANQUE} - GC',
                                        style: AppTheme.textStyles.titleCharts),
                                    Text('Cap. ${tanque.CAPACIDADE} LT',
                                        style: AppTheme.textStyles.titleCharts),
                                    Container(
                                      width: 230,
                                      height: 230,
                                      child: SfCircularChart(
                                        annotations: <CircularChartAnnotation>[
                                          CircularChartAnnotation(
                                            height: '100%',
                                            width: '100%',
                                            widget: Container(
                                              child: PhysicalModel(
                                                shape: BoxShape.circle,
                                                elevation: 10,
                                                shadowColor: Colors.black,
                                                color: Color.fromRGBO(
                                                    230, 230, 230, 1),
                                                child: Container(),
                                              ),
                                            ),
                                          ),
                                          CircularChartAnnotation(
                                            widget: Container(
                                              child: Text(
                                                '${tanque.VOLUME.Litros()} LT\n(${((tanque.VOLUME / tanque.CAPACIDADE) * 100).Porcentagem()} %)',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Color(0xFF947400),
                                                    fontSize: 14),
                                              ),
                                            ),
                                          )
                                        ],
                                        series: getChartDados(),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList())
                      : LoadingWidget(
                          size: Size(160, 160),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Returns the doughnut series which need to be center elevation.
  List<DoughnutSeries<TanquesData, String>> getChartDados() {
    final List<TanquesData> chartData = montaGrafico();

    return <DoughnutSeries<TanquesData, String>>[
      DoughnutSeries<TanquesData, String>(
          dataSource: chartData,
          animationDuration: 700,
          xValueMapper: (TanquesData data, _) => data.x,
          yValueMapper: (TanquesData data, _) => data.y,
          pointColorMapper: (TanquesData data, _) => data.color)
    ];
  }
}

class TanquesData {
  TanquesData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
