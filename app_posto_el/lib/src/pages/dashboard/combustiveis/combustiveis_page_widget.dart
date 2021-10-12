import 'package:app_posto_el/src/configs/global_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/combustiveis/controllers/combustiveis_status.dart';
import 'package:app_posto_el/src/pages/dashboard/combustiveis/models/combustiveis_model.dart';
import 'package:app_posto_el/src/pages/dashboard/widgets/loading_widget.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:app_posto_el/src/utils/formatters.dart';
import 'package:flutter/cupertino.dart';
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
    Color(0xFFFEAF06),
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
                            children: tanques
                                .where((tanque) =>
                                    tanque.CCUSTO == controller.dropdownValue)
                                .map((tanque) => Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text('TANQUE ${tanque.TANQUE} - GC',
                                                style: AppTheme
                                                    .textStyles.titleCharts),
                                            Text(
                                                'Cap. ${tanque.CAPACIDADE.LitrosInt()} LT',
                                                style: AppTheme
                                                    .textStyles.titleCharts),
                                            Container(
                                              width: 230,
                                              height: 230,
                                              child: SfCircularChart(
                                                key: UniqueKey(),
                                                tooltipBehavior:
                                                    TooltipBehavior(
                                                  tooltipPosition:
                                                      TooltipPosition.pointer,
                                                  enable: true,
                                                  color: Colors.white,
                                                  textStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  shadowColor: AppTheme
                                                      .colors.secondaryColor,
                                                ),
                                                onTooltipRender:
                                                    (TooltipArgs args) {
                                                  args.header =
                                                      'Capacidade - ${tanque.CAPACIDADE.LitrosInt()}';
                                                  args.text =
                                                      'Usado - ${tanque.VOLUME.Litros()}';
                                                },
                                                annotations: <
                                                    CircularChartAnnotation>[
                                                  CircularChartAnnotation(
                                                    height: '100%',
                                                    width: '100%',
                                                    widget: Container(
                                                      child: PhysicalModel(
                                                        shape: BoxShape.circle,
                                                        elevation: 10,
                                                        shadowColor:
                                                            Colors.black,
                                                        color: Color.fromRGBO(
                                                            230, 230, 230, 1),
                                                        child: Container(),
                                                      ),
                                                    ),
                                                  ),
                                                  CircularChartAnnotation(
                                                    widget: Container(
                                                      child: Text(
                                                        '${tanque.VOLUME.Litros()} LT\n(${((tanque.VOLUME / tanque.CAPACIDADE) * 100).Porcentagem()}% )',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: colors[
                                                                tanques.indexOf(
                                                                    tanque)],
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                                series: getSeriesTanques(
                                                    tanque: tanque,
                                                    index: tanques
                                                        .indexOf(tanque)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ))
                                .toList(),
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

  /// Returns the doughnut series which need to be center elevation.
  List<DoughnutSeries<TanqueData, String>> getSeriesTanques(
      {required CombustiveisModel tanque, required int index}) {
    final List<TanqueData> chartData = [
      TanqueData(
          x: 'A', y: tanque.VOLUME.toDouble(), pointColor: colors[index]),
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
