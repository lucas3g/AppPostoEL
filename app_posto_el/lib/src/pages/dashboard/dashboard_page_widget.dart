import 'package:app_posto_el/src/pages/dashboard/widgets/drop_down_widget.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoardPageWidget extends StatelessWidget {
  var _currentIndex = 0.obs;
  var pages = [
    Container(
      child: Center(
        child: Text('Vendas'),
      ),
    ),
    Container(
      child: Center(
        child: Text('Combustíveis'),
      ),
    ),
  ];

  ClipRRect _bottomNavBar() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: Obx(
        () => BottomNavigationBar(
          currentIndex: _currentIndex.value,
          onTap: (index) {
            _currentIndex.value = index;
          },
          selectedLabelStyle: TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
          backgroundColor: AppTheme.colors.secondaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.7),
          items: [
            BottomNavigationBarItem(
                label: 'Vendas', icon: Icon(Icons.wallet_giftcard)),
            BottomNavigationBarItem(
                label: 'Combustíves', icon: Icon(Icons.ev_station)),
          ],
        ),
      ),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text('Vendas de Hoje',
                      style: AppTheme.textStyles.dropdownText),
                  Text('372,65 LT',
                      style: AppTheme.textStyles.dropdownText
                          .copyWith(color: Colors.green)),
                ],
              ),
              Column(
                children: [
                  Text('Vendas do Mês',
                      style: AppTheme.textStyles.dropdownText),
                  Text('10.953,49 LT',
                      style: AppTheme.textStyles.dropdownText
                          .copyWith(color: Colors.green)),
                ],
              ),
              Column(
                children: [
                  Text('Proj. de Vendas',
                      style: AppTheme.textStyles.dropdownText),
                  Text('12.170,45 LT',
                      style: AppTheme.textStyles.dropdownText
                          .copyWith(color: Colors.blue)),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget _appBar() {
    return PreferredSize(
      child: AppBar(
        elevation: 0,
        bottomOpacity: 0.0,
        centerTitle: true,
        leading: Container(),
        backgroundColor: AppTheme.colors.secondaryColor,
        title: Obx(() =>
            _currentIndex.value == 0 ? Text('Vendas') : Text('Combustíves')),
      ),
      preferredSize: Size.fromHeight(40),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      body: _body(size.height * 0.05),
      bottomNavigationBar: _bottomNavBar(),
    );
  }
}
