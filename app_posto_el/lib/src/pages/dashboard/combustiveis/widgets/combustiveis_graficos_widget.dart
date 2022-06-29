import 'package:app_posto_el/src/pages/dashboard/combustiveis/models/combustiveis_model.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:app_posto_el/src/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CombustiveisGraficoWidget extends StatelessWidget {
  final CombustiveisModel tanque;
  final int indexTanque;

  CombustiveisGraficoWidget({
    Key? key,
    required this.tanque,
    required this.indexTanque,
  }) : super(key: key);

  final List<Color> colors = [
    const Color(0xFFba0000),
    const Color(0xFFff5900),
    const Color(0xFF54ba00),
    const Color(0xFF00b1ba),
    const Color(0xFF0019ba),
    const Color(0xFFb400ba),
    const Color(0xFFb7ba00),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('TANQUE ${tanque.descResumida}',
            style: AppTheme.textStyles.titleCharts),
        Text('Cap. ${tanque.capacidade.LitrosInt()} LT',
            style: AppTheme.textStyles.titleCharts),
        Text('Resta: ${(tanque.capacidade - tanque.volume).Litros()} LT',
            style: AppTheme.textStyles.titleCharts),
        SizedBox(
          width: 170,
          height: 170,
          child: SfCircularChart(
            key: UniqueKey(),
            tooltipBehavior: TooltipBehavior(
              tooltipPosition: TooltipPosition.pointer,
              enable: true,
              color: Colors.white,
              textStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              shadowColor: colors[indexTanque],
            ),
            onTooltipRender: (TooltipArgs args) {
              args.header = 'Capacidade: ${tanque.capacidade.LitrosInt()}';
              args.text =
                  'Usado: ${tanque.volume.Litros()}\nResta: ${(tanque.capacidade - tanque.volume).Litros()}';
            },
            annotations: <CircularChartAnnotation>[
              CircularChartAnnotation(
                height: '100%',
                width: '100%',
                widget: Container(
                  child: PhysicalModel(
                    shape: BoxShape.circle,
                    elevation: 10,
                    shadowColor: Colors.black,
                    color: const Color.fromRGBO(230, 230, 230, 1),
                    child: Container(),
                  ),
                ),
              ),
              CircularChartAnnotation(
                widget: Container(
                  child: Text(
                    '${tanque.volume.Litros()} LT\n(${((tanque.volume / tanque.capacidade) * 100).Porcentagem()}% )',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: colors[indexTanque],
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
            series: getSeriesTanques(tanque: tanque, index: indexTanque),
          ),
        ),
      ],
    );
  }

  List<DoughnutSeries<TanqueData, String>> getSeriesTanques(
      {required CombustiveisModel tanque, required int index}) {
    final List<TanqueData> chartData = [
      TanqueData(
          x: 'A',
          y: tanque.volume.toDouble(),
          pointColor: index < colors.length ? colors[index] : colors[0]),
      TanqueData(
          x: 'B',
          y: tanque.volume.toDouble() > tanque.capacidade.toDouble()
              ? 0
              : tanque.capacidade.toDouble() - tanque.volume.toDouble(),
          pointColor: const Color.fromRGBO(230, 230, 230, 1))
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
