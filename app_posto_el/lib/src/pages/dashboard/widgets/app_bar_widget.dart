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
                height: 100,
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
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
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
          preferredSize: Size.fromHeight(100),
        );
}


// Container(
//                 margin: EdgeInsets.only(bottom: 10 * 2.5),
//                 child: Stack(
//                   children: [
//                     Container(
//                       height: size,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(25),
//                             bottomRight: Radius.circular(25),
//                           ),
//                           color: AppTheme.colors.secondaryColor),
//                     ),
//                     SizedBox(
//                       height: 65,
//                     ),
//                     //DropDownWidget(),
//                   ],
//                 ),
//               ),


// AppBar(
//             elevation: 0,
//             bottomOpacity: 0.0,
//             centerTitle: true,
//             leading: Container(),
//             backgroundColor: AppTheme.colors.secondaryColor,
//             title: currentIndex == 0 ? Text('Vendas') : Text('Combustíves'),
//           ),