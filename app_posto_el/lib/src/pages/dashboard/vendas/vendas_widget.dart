import 'package:app_posto_el/src/configs/global_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/vendas/controllers/vendas_status.dart';
import 'package:app_posto_el/src/pages/dashboard/widgets/loading_widget.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:app_posto_el/src/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class VendasWidget extends StatefulWidget {
  const VendasWidget({Key? key}) : super(key: key);

  @override
  State<VendasWidget> createState() => _VendasWidgetState();
}

class _VendasWidgetState extends State<VendasWidget> {
  final controller = GlobalSettings().controllerLocais;
  final controllerVendas = GlobalSettings().controllerVendas;
  final List<VendasSemanais> vendasSemanais = [];
  void getVendas() async {
    await controllerVendas.getVendas();
  }

  String somaVendas() {
    var inicio = DateTime.now().subtract(Duration(days: 7));

    final double result = controllerVendas.vendas
        .where((venda) =>
            !DateTime.parse(venda.DATA.toString()).isBefore(inicio) &&
            venda.ID == controller.dropdownValue)
        .map((venda) => venda.VLR_TOTAL)
        .reduce((value, element) => value + element);
    return result.reais();
  }

  String projecaoVenda() {
    final double total = controllerVendas.vendas
        .where((venda) => venda.ID == controller.dropdownValue)
        .map((venda) => venda.VLR_TOTAL)
        .reduce((value, element) => value + element);
    final dias = DateTime.now();

    final double mediaDiaria =
        total / dias.difference(DateTime(dias.year, dias.month, 0)).inDays;

    final result = mediaDiaria * (DateTime(dias.year, dias.month + 1, 0).day);

    return result.reais();
  }

  montaGrafico() {
    var listaNova = controllerVendas.vendas
        .where((venda) => venda.ID == controller.dropdownValue)
        .map((venda) => VendasSemanais(venda.DATA!, venda.VLR_TOTAL))
        .toList();
    listaNova.sort((a, b) => a.dia.isAfter(b.dia) ? 1 : -1);
    return listaNova;
  }

  @override
  void initState() {
    getVendas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Observer(
      builder: (_) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text('Vendas de Hoje',
                      style: AppTheme.textStyles.dropdownText),
                  controllerVendas.status == VendasStatus.success
                      ? Text('354,57 LT',
                          style: AppTheme.textStyles.dropdownText
                              .copyWith(color: Colors.green))
                      : LoadingWidget(size: Size(100, 20)),
                  SizedBox(
                    height: 1,
                  ),
                  controllerVendas.status == VendasStatus.success
                      ? Text(
                          controllerVendas.vendas
                              .firstWhere((venda) =>
                                  venda.ID == controller.dropdownValue)
                              .VLR_TOTAL
                              .reais(),
                          style: AppTheme.textStyles.dropdownText.copyWith(
                              color: Colors.green, fontWeight: FontWeight.w900))
                      : LoadingWidget(size: Size(100, 20)),
                ],
              ),
              Column(
                children: [
                  Text('Vendas da Semana',
                      style: AppTheme.textStyles.dropdownText),
                  controllerVendas.status == VendasStatus.success
                      ? Text('10.953,49 LT',
                          style: AppTheme.textStyles.dropdownText
                              .copyWith(color: Colors.green))
                      : LoadingWidget(size: Size(100, 20)),
                  SizedBox(
                    height: 1,
                  ),
                  controllerVendas.status == VendasStatus.success
                      ? Text(somaVendas(),
                          style: AppTheme.textStyles.dropdownText.copyWith(
                              color: Colors.green, fontWeight: FontWeight.w900))
                      : LoadingWidget(size: Size(100, 20)),
                ],
              ),
              Column(
                children: [
                  Text('Proj. de Vendas',
                      style: AppTheme.textStyles.dropdownText),
                  controllerVendas.status == VendasStatus.success
                      ? Text('12.170,45 LT',
                          style: AppTheme.textStyles.dropdownText
                              .copyWith(color: Colors.blue))
                      : LoadingWidget(size: Size(100, 20)),
                  SizedBox(
                    height: 1,
                  ),
                  controllerVendas.status == VendasStatus.success
                      ? Text(projecaoVenda(),
                          style: AppTheme.textStyles.dropdownText.copyWith(
                              color: Colors.blue, fontWeight: FontWeight.w900))
                      : LoadingWidget(size: Size(100, 20)),
                ],
              )
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
            height: size.height * 0.37,
            child: controllerVendas.status == VendasStatus.success
                ? SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    series: <LineSeries<VendasSemanais, String>>[
                      LineSeries<VendasSemanais, String>(
                          color: Colors.red,
                          width: 2,
                          // Bind data source
                          dataSource: montaGrafico(),
                          xValueMapper: (VendasSemanais vendas, _) =>
                              vendas.dia.Dia(),
                          yValueMapper: (VendasSemanais vendas, _) =>
                              vendas.valor,
                          dataLabelSettings: DataLabelSettings(isVisible: true))
                    ],
                    title: ChartTitle(
                        text: 'Vendas dos Últimos 7 dias',
                        textStyle: AppTheme.textStyles.dropdownText),
                  )
                : LoadingWidget(size: Size(400, 0)),
          ),
          Container(
            height: size.height * 0.05,
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
            builder: (_) => controllerVendas.status == VendasStatus.success
                ? Column(
                    children: List.generate(
                      5,
                      (index) => ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '27/09',
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '372,65 LT',
                                style: AppTheme.textStyles.dropdownText
                                    .copyWith(fontSize: 16),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Text('R\$ 1.372.34',
                                  style: AppTheme.textStyles.dropdownText
                                      .copyWith(fontSize: 16)),
                            ),
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

class VendasSemanais {
  VendasSemanais(this.dia, this.valor);
  final DateTime dia;
  final double valor;
}
