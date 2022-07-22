import 'package:app_posto_el/src/configs/global_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/controllers/controller_locais.dart';
import 'package:app_posto_el/src/pages/dashboard/controllers/locais_status.dart';
import 'package:app_posto_el/src/pages/dashboard/widgets/loading_widget.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:app_posto_el/src/utils/meu_toast.dart';
import 'package:app_posto_el/src/utils/types_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({Key? key}) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  final controller = GetIt.I.get<ControllerLocais>();

  void carregarLocais() async {
    await controller.getLocais();
    if (controller.locais.isNotEmpty) {
      controller.dropdownValue = controller.locais[0].id;
    }
  }

  @override
  void initState() {
    carregarLocais();

    autorun((_) async {
      if (controller.status == LocaisStatus.falhaServidor) {
        MeuToast.toast(
            title: 'Ops... :(',
            message:
                'Erro ao tentar se comunicar com o Servidor... Por favor tente novamente mais tarde.',
            type: TypeToast.noNet,
            context: context);
        await Future.delayed(const Duration(seconds: 4));
        await GlobalSettings().appSettings.removeLogado();
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 10),
              blurRadius: 10,
              color: AppTheme.colors.secondaryColor.withOpacity(0.23)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Observer(
          builder: (_) => controller.status == LocaisStatus.success
              ? DropdownButton(
                  borderRadius: BorderRadius.circular(20),
                  value: controller.dropdownValue,
                  isExpanded: true,
                  icon: const Icon(
                    Icons.arrow_circle_down_sharp,
                  ),
                  iconSize: 30,
                  elevation: 8,
                  iconEnabledColor: AppTheme.colors.secondaryColor,
                  style: AppTheme.textStyles.dropdownText,
                  underline: Container(),
                  onChanged: (newValue) {
                    controller.dropdownValue = newValue as int;
                  },
                  items: controller.locais.map((local) {
                    return DropdownMenuItem(
                      value: local.id,
                      child: Text(local.descricao),
                    );
                  }).toList(),
                )
              : const LoadingWidget(
                  size: Size(double.infinity, 30),
                  radius: 10,
                ),
        ),
      ),
    );
  }
}
