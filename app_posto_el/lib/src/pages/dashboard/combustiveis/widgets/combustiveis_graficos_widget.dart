import 'package:app_posto_el/src/pages/dashboard/combustiveis/models/combustiveis_model.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:app_posto_el/src/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CombustiveisGraficoWidget extends StatefulWidget {
  final CombustiveisModel tanque;
  final int indexTanque;
  CombustiveisGraficoWidget(
      {Key? key, required this.tanque, required this.indexTanque})
      : super(key: key);

  @override
  _CombustiveisGraficoWidgetState createState() =>
      _CombustiveisGraficoWidgetState();
}

class _CombustiveisGraficoWidgetState extends State<CombustiveisGraficoWidget> {
  late CombustiveisModel tanque = widget.tanque;
  final List<Color> colors = [
    Color(0xFFFF7F26),
    Color(0xFFC627F8),
    Color(0xFFAB0155),
    Color(0xFF2A2F3B),
    Color(0xFF18BCF4),
    Color(0xFF07311D),
    Color(0xFFAB414D),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('TANQUE ${tanque.TANQUE} - GC',
            style: AppTheme.textStyles.titleCharts),
        Text('Cap. ${tanque.CAPACIDADE.LitrosInt()} LT',
            style: AppTheme.textStyles.titleCharts),
        Container(
          width: 180,
          height: 180,
          child: SfCircularChart(
            key: UniqueKey(),
            tooltipBehavior: TooltipBehavior(
              tooltipPosition: TooltipPosition.pointer,
              enable: true,
              color: Colors.white,
              textStyle:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              shadowColor: colors[widget.indexTanque],
            ),
            onTooltipRender: (TooltipArgs args) {
              args.header = 'Capacidade: ${tanque.CAPACIDADE.LitrosInt()}';
              args.text =
                  'Usado: ${tanque.VOLUME.Litros()}\nResta: ${(tanque.CAPACIDADE - tanque.VOLUME).Litros()}';
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
                    color: Color.fromRGBO(230, 230, 230, 1),
                    child: Container(),
                  ),
                ),
              ),
              CircularChartAnnotation(
                widget: Container(
                  child: Text(
                    '${tanque.VOLUME.Litros()} LT\n(${((tanque.VOLUME / tanque.CAPACIDADE) * 100).Porcentagem()}% )',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: colors[widget.indexTanque],
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
            series: getSeriesTanques(tanque: tanque, index: widget.indexTanque),
          ),
        ),
      ],
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
