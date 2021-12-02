import 'package:app_posto_el/src/configs/global_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/saldo_cr/controller/saldo_status.dart';
import 'package:app_posto_el/src/pages/dashboard/saldo_cr/model/saldo_model.dart';
import 'package:app_posto_el/src/pages/dashboard/widgets/loading_widget.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:app_posto_el/src/utils/formatters.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class SaldoCRPage extends StatefulWidget {
  const SaldoCRPage({Key? key}) : super(key: key);

  @override
  State<SaldoCRPage> createState() => _SaldoCRPageState();
}

class _SaldoCRPageState extends State<SaldoCRPage> {
  final controller = GlobalSettings().controllerSaldo;
  final controllerLocais = GlobalSettings().controllerLocais;
  final TextEditingController controllerInput = TextEditingController();

  List<SaldoModel> filteredUsers = [];

  void getSaldo() async {
    controllerInput.clear();

    if (controller.saldo.isEmpty) {
      await controller.getSaldo();
      setState(() {
        filteredUsers = controller.saldo
            .where((e) => e.local == controllerLocais.dropdownValue)
            .toList();
      });
    } else {
      filteredUsers =
          await controller.filtro(local: controllerLocais.dropdownValue);
    }
  }

  void _onSearchChanged(String value) async {
    filteredUsers = await controller.onSearchChanged(
        value: value, local: controllerLocais.dropdownValue);
    setState(() {});
  }

  @override
  void initState() {
    autorun((_) {
      getSaldo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return controller.status == SaldoStatus.success
          ? Column(
              children: [
                Theme(
                  data: ThemeData(
                    colorScheme: ThemeData().colorScheme.copyWith(
                          primary: AppTheme.colors.secondaryColor,
                        ),
                  ),
                  child: PhysicalModel(
                    color: Colors.white,
                    elevation: 8,
                    shadowColor: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                    child: TextFormField(
                      controller: controllerInput,
                      inputFormatters: [UpperCaseTextFormatter()],
                      onChanged: (value) {
                        EasyDebounce.debounce(
                            'my-debouncer',
                            Duration(milliseconds: 500),
                            () => _onSearchChanged(value));
                      },
                      cursorColor: AppTheme.colors.primaryColor,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        isDense: true,
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          size: 25,
                        ),
                        suffixIcon: controllerInput.value.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  size: 25,
                                ),
                                onPressed: () {
                                  controllerInput.clear();
                                  _onSearchChanged('');
                                },
                              )
                            : null,
                        hintText: 'Pesquisar um cliente',
                        alignLabelWithHint: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: AppTheme.colors.secondaryColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Geral',
                        style: AppTheme.textStyles.dropdownText
                            .copyWith(fontSize: 16),
                      ),
                      Text(
                        filteredUsers.isNotEmpty
                            ? filteredUsers
                                .where((saldo) =>
                                    saldo.local ==
                                    controllerLocais.dropdownValue)
                                .map((saldo) => saldo.saldoAtual)
                                .reduce((value, element) => value! + element!)!
                                .toDouble()
                                .reais()
                            : "R\$ 0.00",
                        style: AppTheme.textStyles.dropdownText.copyWith(
                            fontSize: 30,
                            color: AppTheme.colors.secondaryColor),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    if (filteredUsers.isNotEmpty) ...[
                      ...filteredUsers.map((saldo) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      saldo.nomeCliente!,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      softWrap: true,
                                    ),
                                  ),
                                  Text(
                                    saldo.saldoAtual!.toDouble().reais(),
                                    textAlign: TextAlign.end,
                                    style: AppTheme.textStyles.dropdownText
                                        .copyWith(
                                            fontSize: 16,
                                            color:
                                                AppTheme.colors.secondaryColor),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                              )
                            ],
                          ),
                        );
                      })
                    ] else ...[
                      Text('Nenhum cliente encontrado!')
                    ]
                  ],
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoadingWidget(size: Size(100, 35), radius: 20),
                SizedBox(
                  height: 10,
                ),
                LoadingWidget(size: Size(150, 50), radius: 20),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LoadingWidget(size: Size(250, 30), radius: 20),
                    LoadingWidget(size: Size(100, 30), radius: 20),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LoadingWidget(size: Size(250, 30), radius: 20),
                    LoadingWidget(size: Size(100, 30), radius: 20),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LoadingWidget(size: Size(250, 30), radius: 20),
                    LoadingWidget(size: Size(100, 30), radius: 20),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LoadingWidget(size: Size(250, 30), radius: 20),
                    LoadingWidget(size: Size(100, 30), radius: 20),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LoadingWidget(size: Size(250, 30), radius: 20),
                    LoadingWidget(size: Size(100, 30), radius: 20),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LoadingWidget(size: Size(250, 30), radius: 20),
                    LoadingWidget(size: Size(100, 30), radius: 20),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LoadingWidget(size: Size(250, 30), radius: 20),
                    LoadingWidget(size: Size(100, 30), radius: 20),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LoadingWidget(size: Size(250, 30), radius: 20),
                    LoadingWidget(size: Size(100, 30), radius: 20),
                  ],
                )
              ],
            );
    });
  }
}
