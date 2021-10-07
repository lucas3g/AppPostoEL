import 'package:app_posto_el/src/configs/app_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/widgets/drop_down_widget.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppBarWidget extends PreferredSize {
  final int currentIndex;
  final Size size;
  final BuildContext context;
  AppBarWidget(
      {Key? key,
      required this.currentIndex,
      required this.size,
      required this.context})
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
                    padding: EdgeInsets.only(top: size.height * 0.04),
                    child: Container(
                      height: size.height * 0.05,
                      child: Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          Text(
                            currentIndex == 0
                                ? 'Vendas'
                                : 'Tanques de Combustível',
                            style: AppTheme.textStyles.title,
                            textAlign: TextAlign.center,
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              await GetIt.I.get<AppSettigns>().removeLogado();
                              Navigator.popAndPushNamed(context, '/login');
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  DropDownWidget(),
                ],
              ),
            ],
          ),
          preferredSize: Size.fromHeight(size.height * 0.15),
        );
}
