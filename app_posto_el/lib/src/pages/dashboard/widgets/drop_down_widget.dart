import 'package:app_posto_el/src/pages/dashboard/controllers/controller_locais.dart';
import 'package:app_posto_el/src/pages/dashboard/models/model_locais.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({Key? key}) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  final controller = ControllerLocais();

  @override
  void initState() {
    autorun((_) {
      controller.getLocais();
      setState(() {});
    });
    super.initState();
  }

  late String dropdownValue = controller.locais.descricao ?? 'Empresa Teste';
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
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
          child: DropdownButton(
            value: dropdownValue,
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
              dropdownValue = newValue as String;
              setState(() {});
            },
            items: <String>[controller.locais.descricao ?? 'Empresa Teste']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
