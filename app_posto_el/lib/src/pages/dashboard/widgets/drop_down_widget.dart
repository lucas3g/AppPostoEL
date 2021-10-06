import 'package:app_posto_el/src/pages/dashboard/controllers/controller_locais.dart';
import 'package:app_posto_el/src/pages/dashboard/controllers/locais_status.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({Key? key}) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  final ControllerLocais controller = ControllerLocais();

  void carregarLocais() async {
    await controller.getLocais();
    controller.dropdownValue = controller.locais.descricao;
  }

  @override
  void initState() {
    carregarLocais();
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
        child: Observer(builder: (_) {
          return controller.status == LocaisStatus.success
              ? DropdownButton(
                  value: controller.dropdownValue,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  iconEnabledColor: AppTheme.colors.secondaryColor,
                  style: AppTheme.textStyles.dropdownText,
                  underline: Container(
                    color: Colors.white,
                  ),
                  onChanged: (newValue) {
                    controller.dropdownValue = newValue as String;
                  },
                  items: <String>[controller.locais.descricao]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              : CircularProgressIndicator(
                  color: Color(0xffcf1f36),
                );
        }),
      ),
    );
  }
}
