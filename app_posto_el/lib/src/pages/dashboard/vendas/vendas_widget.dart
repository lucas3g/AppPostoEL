import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VendasWidget extends StatelessWidget {
  const VendasWidget({Key? key}) : super(key: key);

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
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: const <Widget>[
                    Expanded(
                      child: Text('Data'),
                    ),
                    Expanded(
                      child: Text('Litros'),
                    ),
                    Expanded(
                      child: Text('Valor R\$'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(), //<--here
              shrinkWrap: true,
              itemCount: 15,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(child: Text('27/09')),
                      Expanded(child: Text('372,65 LT')),
                      Expanded(child: Text('R\$ 1.372.34')),
                    ],
                  ),
                );
              })
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
