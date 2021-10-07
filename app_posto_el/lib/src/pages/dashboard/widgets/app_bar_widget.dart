import 'package:app_posto_el/src/pages/dashboard/widgets/drop_down_widget.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends PreferredSize {
  final int currentIndex;
  final Size size;
  AppBarWidget({Key? key, required this.currentIndex, required this.size})
      : super(
          key: key,
          child: Stack(
            children: [
              Container(
                height: size.height * 0.13,
                decoration: BoxDecoration(
                  color: AppTheme.colors.secondaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 35),
                    child: Text(
                      currentIndex == 0 ? 'Vendas' : 'Tanques de Combustível',
                      style: AppTheme.textStyles.title,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownWidget(),
                ],
              ),
            ],
          ),
          preferredSize: Size.fromHeight(size.height * 0.17),
        );
}
