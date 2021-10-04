import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CombustiveisPageWidget extends StatelessWidget {
  const CombustiveisPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildElevationDoughnutChart();
  }

  Padding _buildElevationDoughnutChart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text('TANQUE 1 - GC'),
              Text('Cap. 10.000 LT'),
              Container(
                width: 200,
                height: 200,
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
                          style:
                              TextStyle(color: Color(0xFF947400), fontSize: 16),
                        ),
                      ),
                    )
                  ],

                  series: _getElevationDoughnutSeries(),
                ),
              ),
            ],
          ),
          // Text('TANQUE 3 - ET'),
          // Text('Cap. 10.000 LT'),
          // Container(
          //   width: 200,
          //   height: 200,
          //   child: SfCircularChart(
          //     /// It used to set the annotation on circular chart.
          //     annotations: <CircularChartAnnotation>[
          //       CircularChartAnnotation(
          //         height: '100%',
          //         width: '100%',
          //         widget: Container(
          //           child: PhysicalModel(
          //             shape: BoxShape.circle,
          //             elevation: 10,
          //             shadowColor: Colors.black,
          //             color: Color.fromRGBO(230, 230, 230, 1),
          //             child: Container(),
          //           ),
          //         ),
          //       ),
          //       CircularChartAnnotation(
          //         widget: Container(
          //           child: const Text(
          //             '3.855 LT\n(38.55%)',
          //             style: TextStyle(color: Color(0xFF18BCF4), fontSize: 16),
          //           ),
          //         ),
          //       )
          //     ],
          //     series: _getElevationDoughnutSeriesAzul(),
          //   ),
          // ),
        ],
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
      ChartSampleData(x: 'A', y: 62, color: Color(0xFF15BEF4)),
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
}

class ChartSampleData {
  ChartSampleData({required this.x, required this.y, required this.color});
  final String x;
  final double y;
  final Color color;
}
