import 'package:app_posto_el/src/pages/dashboard/widgets/drop_down_widget.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends PreferredSize {
  final int currentIndex;
  AppBarWidget({Key? key, required this.currentIndex})
      : super(
          key: key,
          child: Stack(
            children: [
              Container(
                height: 100 * 0.99,
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
                      padding: EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          currentIndex == 0
                              ? Text(
                                  'Vendas',
                                  style: AppTheme.textStyles.title,
                                )
                              : Text(
                                  'Tanques de Combustível',
                                  style: AppTheme.textStyles.title,
                                ),
                        ],
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownWidget(),
                ],
              ),
            ],
          ),
          preferredSize: Size.fromHeight(140),
        );
}
