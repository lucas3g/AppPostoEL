import 'package:app_posto_el/src/pages/dashboard/controllers/controller_locais.dart';
import 'package:app_posto_el/src/pages/dashboard/controllers/locais_status.dart';
import 'package:app_posto_el/src/pages/dashboard/widgets/loading_widget.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VendasWidget extends StatefulWidget {
  const VendasWidget({Key? key}) : super(key: key);

  @override
  State<VendasWidget> createState() => _VendasWidgetState();
}

class _VendasWidgetState extends State<VendasWidget> {
  final controller = ControllerLocais();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text('Vendas de Hoje',
                      style: AppTheme.textStyles.dropdownText),
                  Text('372,65 LT',
                      style: AppTheme.textStyles.dropdownText
                          .copyWith(color: Colors.green)),
                ],
              ),
              Column(
                children: [
                  Text('Vendas do Mês',
                      style: AppTheme.textStyles.dropdownText),
                  Text('10.953,49 LT',
                      style: AppTheme.textStyles.dropdownText
                          .copyWith(color: Colors.green)),
                ],
              ),
              Column(
                children: [
                  Text('Proj. de Vendas',
                      style: AppTheme.textStyles.dropdownText),
                  Text('12.170,45 LT',
                      style: AppTheme.textStyles.dropdownText
                          .copyWith(color: Colors.blue)),
                ],
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 270,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <LineSeries<SalesData, String>>[
                LineSeries<SalesData, String>(
                    color: Colors.red,
                    width: 2,
                    // Bind data source
                    dataSource: <SalesData>[
                      SalesData('Jan', 100000),
                      SalesData('Feb', 250000),
                      SalesData('Mar', 200000),
                      SalesData('Apr', 150000),
                      SalesData('May', 300000)
                    ],
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales,
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ],
              title: ChartTitle(
                  text: 'Vendas dos Últimos 7 dias',
                  textStyle: AppTheme.textStyles.dropdownText),
            ),
          ),
          Container(
            height: 35,
            child: ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Data',
                      style: AppTheme.textStyles.dropdownText
                          .copyWith(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Litros',
                      style: AppTheme.textStyles.dropdownText
                          .copyWith(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Text(
                      'Valor R\$',
                      style: AppTheme.textStyles.dropdownText
                          .copyWith(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Observer(
            builder: (_) => controller.status == LocaisStatus.success
                ? Column(
                    children: List.generate(
                      10,
                      (index) => ListTile(
                        title: Row(
                          children: [
                            Expanded(child: Text('27/09')),
                            Expanded(child: Text('372,65 LT')),
                            Expanded(flex: 0, child: Text('R\$ 1.372.34')),
                          ],
                        ),
                      ),
                    ),
                  )
                : Column(
                    children: List.generate(
                      10,
                      (index) => ListTile(
                        title: Row(
                          children: [
                            LoadingWidget(size: Size(81, 29)),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(child: LoadingWidget(size: Size(81, 29))),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(child: LoadingWidget(size: Size(81, 29))),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
