import 'package:app_posto_el/src/configs/app_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/widgets/drop_down_widget.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

class AppBarWidget extends StatelessWidget implements PreferredSize {
  final int currentIndex;
  final Size size;
  final BuildContext context;

  const AppBarWidget(
      {Key? key,
      required this.currentIndex,
      required this.size,
      required this.context})
      : super(key: key);

  void confirmarSair() {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.only(bottom: 15, top: 20, right: 20, left: 20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/images/sair.svg',
                height: 130,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Deseja realmente sair da aplicação?',
                style: AppTheme.textStyles.titleCharts.copyWith(fontSize: 16),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: const Text('Não'),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await GetIt.I.get<AppSettigns>().removeLogado();
                        await Future.delayed(const Duration(milliseconds: 150));
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text('Sim'),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }

  @override
  Widget get child => Stack(
        children: [
          Container(
            height: size.height * .13,
            decoration: BoxDecoration(
              color: AppTheme.colors.secondaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        currentIndex == 0
                            ? 'Vendas'
                            : currentIndex == 1
                                ? 'Tanques de Combustível'
                                : 'Saldo - Contas a Receber',
                        style: AppTheme.textStyles.title,
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          confirmarSair();
                        },
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              const DropDownWidget(),
            ],
          ),
        ],
      );

  @override
  Size get preferredSize => Size.fromHeight(size.height * .18);
}
