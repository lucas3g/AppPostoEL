import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CombustiveisPageWidget extends StatelessWidget {
  const CombustiveisPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildElevationDoughnutChart();
  }

  Center _buildElevationDoughnutChart() {
    return Center(
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Text('TANQUE 1 - GC',
                        style: AppTheme.textStyles.titleCharts),
                    Text('Cap. 10.000 LT',
                        style: AppTheme.textStyles.titleCharts),
                    Container(
                      width: 170,
                      height: 170,
                      child: SfCircularChart(
                        /// It used to set the annotation on circular chart.
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
                              child: const Text(
                                '3.855 LT\n(38.55%)',
                                style: TextStyle(
                                    color: Color(0xFF947400), fontSize: 14),
                              ),
                            ),
                          )
                        ],

                        series: _getElevationDoughnutSeries(),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'TANQUE 2 - DA',
                      style: AppTheme.textStyles.titleCharts,
                    ),
                    Text('Cap. 7.500 LT',
                        style: AppTheme.textStyles.titleCharts),
                    Container(
                      width: 170,
                      height: 170,
                      child: SfCircularChart(
                        /// It used to set the annotation on circular chart.
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
                              child: const Text(
                                '1.974 LT\n(26.32%)',
                                style: TextStyle(
                                    color: Color(0xFF18BCF4), fontSize: 14),
                              ),
                            ),
                          )
                        ],
                        series: _getElevationDoughnutSeriesAzul(),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Text('TANQUE 3 - ET',
                        style: AppTheme.textStyles.titleCharts),
                    Text('Cap. 10.000 LT',
                        style: AppTheme.textStyles.titleCharts),
                    Container(
                      width: 170,
                      height: 170,
                      child: SfCircularChart(
                        /// It used to set the annotation on circular chart.
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
                              child: const Text(
                                '7.790 LT\n(77.90%)',
                                style: TextStyle(
                                    color: Color(0xffC729F7), fontSize: 14),
                              ),
                            ),
                          )
                        ],

                        series: _getElevationDoughnutSeriesRoxo(),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'TANQUE 4 - GA',
                      style: AppTheme.textStyles.titleCharts,
                    ),
                    Text('Cap. 20.000 LT',
                        style: AppTheme.textStyles.titleCharts),
                    Container(
                      width: 170,
                      height: 170,
                      child: SfCircularChart(
                        /// It used to set the annotation on circular chart.
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
                              child: const Text(
                                '7.861 LT\n(39.31%)',
                                style: TextStyle(
                                    color: Color(0xFFF91A49), fontSize: 14),
                              ),
                            ),
                          )
                        ],
                        series: _getElevationDoughnutSeriesVermelho(),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Text('TANQUE 3 - ET',
                        style: AppTheme.textStyles.titleCharts),
                    Text('Cap. 10.000 LT',
                        style: AppTheme.textStyles.titleCharts),
                    Container(
                      width: 170,
                      height: 170,
                      child: SfCircularChart(
                        /// It used to set the annotation on circular chart.
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
                              child: const Text(
                                '7.790 LT\n(77.90%)',
                                style: TextStyle(
                                    color: Color(0xffC729F7), fontSize: 14),
                              ),
                            ),
                          )
                        ],

                        series: _getElevationDoughnutSeriesRoxo(),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'TANQUE 4 - GA',
                      style: AppTheme.textStyles.titleCharts,
                    ),
                    Text('Cap. 20.000 LT',
                        style: AppTheme.textStyles.titleCharts),
                    Container(
                      width: 170,
                      height: 170,
                      child: SfCircularChart(
                        /// It used to set the annotation on circular chart.
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
                              child: const Text(
                                '7.861 LT\n(39.31%)',
                                style: TextStyle(
                                    color: Color(0xFFF91A49), fontSize: 14),
                              ),
                            ),
                          )
                        ],
                        series: _getElevationDoughnutSeriesVermelho(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Returns the doughnut series which need to be center elevation.
  List<DoughnutSeries<ChartSampleData, String>> _getElevationDoughnutSeries() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(x: 'A', y: 62, color: Color(0xFFebc334)),
      ChartSampleData(x: 'B', y: 38, color: Color.fromRGBO(230, 230, 230, 1))
    ];

    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          dataSource: chartData,
          animationDuration: 700,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          pointColorMapper: (ChartSampleData data, _) => data.color)
    ];
  }

  /// Returns the doughnut series which need to be center elevation.
  List<DoughnutSeries<ChartSampleData, String>>
      _getElevationDoughnutSeriesAzul() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(x: 'A', y: 26.32, color: Color(0xFF15BEF4)),
      ChartSampleData(x: 'B', y: 73.68, color: Color.fromRGBO(230, 230, 230, 1))
    ];

    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          dataSource: chartData,
          animationDuration: 700,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          pointColorMapper: (ChartSampleData data, _) => data.color)
    ];
  }

  List<DoughnutSeries<ChartSampleData, String>>
      _getElevationDoughnutSeriesRoxo() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(x: 'A', y: 77.90, color: Color(0xffC729F7)),
      ChartSampleData(x: 'B', y: 12.10, color: Color.fromRGBO(230, 230, 230, 1))
    ];

    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          dataSource: chartData,
          animationDuration: 700,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          pointColorMapper: (ChartSampleData data, _) => data.color)
    ];
  }

  List<DoughnutSeries<ChartSampleData, String>>
      _getElevationDoughnutSeriesVermelho() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(x: 'A', y: 39.31, color: Color(0xFFF91A49)),
      ChartSampleData(x: 'B', y: 60.69, color: Color.fromRGBO(230, 230, 230, 1))
    ];

    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          dataSource: chartData,
          animationDuration: 700,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          pointColorMapper: (ChartSampleData data, _) => data.color)
    ];
  }
}

class ChartSampleData {
  ChartSampleData({required this.x, required this.y, required this.color});
  final String x;
  final double y;
  final Color color;
}
