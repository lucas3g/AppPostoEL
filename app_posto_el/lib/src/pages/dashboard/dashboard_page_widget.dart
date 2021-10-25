import 'package:app_posto_el/src/pages/dashboard/widgets/app_bar_widget.dart';
import 'package:app_posto_el/src/pages/dashboard/widgets/body_widget.dart';
import 'package:app_posto_el/src/pages/dashboard/widgets/dashboard_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DashBoardPageWidget extends StatefulWidget {
  @override
  State<DashBoardPageWidget> createState() => _DashBoardPageWidgetState();
}

class _DashBoardPageWidgetState extends State<DashBoardPageWidget> {
  late int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(
        currentIndex: _currentIndex,
        size: size,
        context: context,
      ),
      body: BodyWidget(currentIndex: _currentIndex),
      bottomNavigationBar: DashBoardBottomNavBar(
        onChanged: (index) {
          _currentIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
