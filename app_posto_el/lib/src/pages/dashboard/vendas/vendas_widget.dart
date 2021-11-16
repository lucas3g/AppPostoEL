import 'package:app_posto_el/src/configs/global_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/vendas/controllers/vendas/vendas_status.dart';
import 'package:app_posto_el/src/pages/dashboard/widgets/loading_widget.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:app_posto_el/src/utils/formatters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import "package:intl/intl.dart";

import 'package:syncfusion_flutter_charts/charts.dart';

class VendasWidget extends StatefulWidget {
  const VendasWidget({Key? key}) : super(key: key);

  @override
  State<VendasWidget> createState() => _VendasWidgetState();
}

class _VendasWidgetState extends State<VendasWidget> {
  final controller = GlobalSettings().controllerLocais;
  final controllerVendas = GlobalSettings().controllerVendas;
  late List<dynamic> listaNova = [];

  void getVendas() async {
    if (controllerVendas.vendas.isEmpty) await controllerVendas.getVendas();
  }

  montaGrafico() {
    var inicio = DateTime.now().subtract(Duration(days: 7));

    listaNova = controllerVendas.vendas
        .where((venda) =>
            !DateTime.parse(venda.data.toString()).isBefore(inicio) &&
            venda.local == controller.dropdownValue)
        .map((venda) => VendasSemanais(venda.data!, venda.vlrTotal))
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
      builder: (_) => AnimatedContainer(
        duration: Duration(seconds: 10),
        child: Container(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('Hoje', style: AppTheme.textStyles.dropdownText),
                        controllerVendas.status == VendasStatus.success
                            ? Text(
                                '${controllerVendas.vendas.firstWhere((venda) => venda.local == controller.dropdownValue).qtdTotal.Litros()} LT',
                                style: AppTheme.textStyles.dropdownText
                                    .copyWith(color: Colors.blue))
                            : LoadingWidget(
                                size: Size(100, 20),
                                radius: 10,
                              ),
                        SizedBox(
                          height: 1,
                        ),
                        controllerVendas.status == VendasStatus.success
                            ? Text(
                                controllerVendas.vendas
                                    .firstWhere((venda) =>
                                        venda.local == controller.dropdownValue)
                                    .vlrTotal
                                    .reais(),
                                style:
                                    AppTheme.textStyles.dropdownText.copyWith(
                                  color: Colors.green,
                                ))
                            : LoadingWidget(
                                size: Size(100, 20),
                                radius: 10,
                              ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text('Semana', style: AppTheme.textStyles.dropdownText),
                        controllerVendas.status == VendasStatus.success
                            ? Text(
                                '${controllerVendas.somaLitros(local: controller.dropdownValue)} LT',
                                style: AppTheme.textStyles.dropdownText
                                    .copyWith(color: Colors.blue))
                            : LoadingWidget(
                                size: Size(100, 20),
                                radius: 10,
                              ),
                        SizedBox(
                          height: 1,
                        ),
                        controllerVendas.status == VendasStatus.success
                            ? Text(
                                controllerVendas.somaVendas(
                                    local: controller.dropdownValue),
                                style:
                                    AppTheme.textStyles.dropdownText.copyWith(
                                  color: Colors.green,
                                ))
                            : LoadingWidget(
                                size: Size(100, 20),
                                radius: 10,
                              ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text('Projeção',
                            style: AppTheme.textStyles.dropdownText),
                        controllerVendas.status == VendasStatus.success
                            ? Text(
                                '${controllerVendas.projecaoLitros(local: controller.dropdownValue)} LT',
                                style: AppTheme.textStyles.dropdownText
                                    .copyWith(color: Colors.blue))
                            : LoadingWidget(
                                size: Size(100, 20),
                                radius: 10,
                              ),
                        SizedBox(
                          height: 1,
                        ),
                        controllerVendas.status == VendasStatus.success
                            ? Text(
                                controllerVendas.projecaoVenda(
                                    local: controller.dropdownValue),
                                style:
                                    AppTheme.textStyles.dropdownText.copyWith(
                                  color: Colors.green,
                                ))
                            : LoadingWidget(
                                size: Size(100, 20),
                                radius: 10,
                              ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Container(
                height: size.height * 0.37,
                child: controllerVendas.status == VendasStatus.success
                    ? SfCartesianChart(
                        tooltipBehavior: TooltipBehavior(
                          enable: true,
                          color: Colors.white,
                          textStyle: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          shadowColor: AppTheme.colors.secondaryColor,
                        ),
                        onTooltipRender: (TooltipArgs args) {
                          final DateTime data =
                              listaNova[args.pointIndex as int].dia!;
                          final double valor =
                              listaNova[args.pointIndex as int].valor;
                          args.header = 'Dia - ${data.DiaMes()}';
                          args.text = valor.reais();
                        },
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(
                            numberFormat:
                                NumberFormat.simpleCurrency(locale: 'pt-br')),
                        series: <CartesianSeries<VendasSemanais, String>>[
                          AreaSeries<VendasSemanais, String>(
                            color: AppTheme.colors.secondaryColor,
                            dataSource: montaGrafico(),
                            xValueMapper: (VendasSemanais vendas, _) =>
                                vendas.dia.Dia(),
                            yValueMapper: (VendasSemanais vendas, _) =>
                                vendas.valor,
                            markerSettings: MarkerSettings(
                                isVisible: true, shape: DataMarkerType.circle),
                          )
                        ],
                        title: ChartTitle(
                            text: 'Vendas dos Últimos 7 dias',
                            textStyle: AppTheme.textStyles.dropdownText),
                      )
                    : LoadingWidget(
                        size: Size(400, 0),
                        radius: 10,
                      ),
              ),
              Container(
                height: size.height * 0.05,
                child: ListTile(
                  title: Row(
                    children: [
                      Text(
                        'Data',
                        style: AppTheme.textStyles.dropdownText
                            .copyWith(fontSize: 16),
                      ),
                      Spacer(),
                      Text(
                        'Litros',
                        style: AppTheme.textStyles.dropdownText
                            .copyWith(fontSize: 16),
                      ),
                      Spacer(),
                      Text(
                        'Valor R\$',
                        style: AppTheme.textStyles.dropdownText
                            .copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Observer(
                builder: (_) => controllerVendas.status == VendasStatus.success
                    ? Column(
                        children: (controllerVendas.vendas
                            .where((local) =>
                                local.local == controller.dropdownValue)
                            .map(
                              (venda) => ListTile(
                                title: Row(
                                  children: [
                                    Text(
                                      venda.data!.DiaMes(),
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      venda.qtdTotal.Litros(),
                                      textAlign: TextAlign.end,
                                      style: AppTheme.textStyles.dropdownText
                                          .copyWith(fontSize: 16),
                                    ),
                                    Spacer(),
                                    Text(venda.vlrTotal.reais(),
                                        style: AppTheme.textStyles.dropdownText
                                            .copyWith(fontSize: 16)),
                                  ],
                                ),
                              ),
                            )).toList(),
                      )
                    : Column(
                        children: List.generate(
                          10,
                          (index) => ListTile(
                            title: Row(
                              children: [
                                LoadingWidget(
                                  size: Size(81, 29),
                                  radius: 10,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: LoadingWidget(
                                    size: Size(81, 29),
                                    radius: 10,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: LoadingWidget(
                                    size: Size(81, 29),
                                    radius: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VendasSemanais {
  VendasSemanais(this.dia, this.valor);
  final DateTime dia;
  final double valor;
}
