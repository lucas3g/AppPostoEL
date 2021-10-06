import 'package:app_posto_el/src/configs/app_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/controllers/controller_locais.dart';
import 'package:app_posto_el/src/pages/dashboard/controllers/locais_status.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({Key? key}) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  final ControllerLocais controller = ControllerLocais();
  void carregarLocais() async {
    await controller.getLocais();
    if (controller.locais.isNotEmpty)
      controller.dropdownValue = controller.locais[0].id;
  }

  @override
  void initState() {
    carregarLocais();
    autorun((_) {
      if (controller.status == LocaisStatus.semInternet) {
        GetIt.I.get<AppSettigns>().removeLogado();
        BotToast.showText(text: 'Celular não está conectado a internet!');
        Navigator.popAndPushNamed(context, '/login');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 10),
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
                  icon: Icon(
                    Icons.arrow_circle_down_sharp,
                  ),
                  iconSize: 30,
                  elevation: 16,
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
              : CircularProgressIndicator(
                  color: Color(0xffcf1f36),
                ),
        ),
      ),
    );
  }
}
