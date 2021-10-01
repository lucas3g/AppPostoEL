import 'package:app_posto_el/src/pages/dashboard/vendas/vendas_widget.dart';
import 'package:app_posto_el/src/pages/dashboard/widgets/dashboard_bottom_nav_bar.dart';
import 'package:app_posto_el/src/pages/dashboard/widgets/drop_down_widget.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DashBoardPageWidget extends StatefulWidget {
  @override
  State<DashBoardPageWidget> createState() => _DashBoardPageWidgetState();
}

class _DashBoardPageWidgetState extends State<DashBoardPageWidget> {
  var _currentIndex = 0;

  var pages = [
    VendasWidget(),
    Container(
      child: Center(
        child: Text('Combustíveis'),
      ),
    ),
  ];

  PreferredSizeWidget _appBar() {
    return PreferredSize(
      child: AppBar(
        elevation: 0,
        bottomOpacity: 0.0,
        centerTitle: true,
        leading: Container(),
        backgroundColor: AppTheme.colors.secondaryColor,
        title: _currentIndex == 0 ? Text('Vendas') : Text('Combustíves'),
      ),
      preferredSize: Size.fromHeight(40),
    );
  }

  Column _body(double size) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10 * 2.5),
          child: Stack(
            children: [
              Container(
                height: size,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    color: AppTheme.colors.secondaryColor),
              ),
              SizedBox(
                height: 65,
              ),
              DropDownWidget(),
            ],
          ),
        ),
        pages[_currentIndex],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      body: _body(size.height * 0.05),
      bottomNavigationBar: DashBoardBottomNavBar(
        onChanged: (index) {
          _currentIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
