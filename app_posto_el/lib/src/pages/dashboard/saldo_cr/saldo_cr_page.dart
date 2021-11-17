import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SaldoCRPage extends StatelessWidget {
  const SaldoCRPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: PhysicalModel(
            color: Colors.white,
            elevation: 8,
            shadowColor: AppTheme.colors.secondaryColor,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cliente',
                    style:
                        AppTheme.textStyles.dropdownText.copyWith(fontSize: 16),
                  ),
                  Text(
                    'Saldo R\$',
                    style:
                        AppTheme.textStyles.dropdownText.copyWith(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
        ),
        PhysicalModel(
          color: Colors.white,
          elevation: 8,
          shadowColor: AppTheme.colors.secondaryColor,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Lucas Emanuel Silva'), Text('910,16')],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
