import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({Key? key}) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  late String dropdownValue = 'Posto Papagaio - Matriz';
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
            items: <String>[
              'Posto Papagaio - Matriz',
              'Posto Papagaio - Centro',
              'Posto Papagaio - Ipiranga',
            ].map<DropdownMenuItem<String>>((String value) {
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
