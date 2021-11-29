import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBoardBottomNavBar extends StatefulWidget {
  final Function(int index) onChanged;
  DashBoardBottomNavBar({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<DashBoardBottomNavBar> createState() => _DashBoardBottomNavBarState();
}

class _DashBoardBottomNavBarState extends State<DashBoardBottomNavBar> {
  late int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 50,
      index: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
          widget.onChanged(index);
        });
      },
      color: AppTheme.colors.secondaryColor,
      animationCurve: Curves.easeInOut,
      backgroundColor: Colors.grey.shade50,
      items: [
        Icon(Icons.attach_money_rounded, color: Colors.white),
        Icon(Icons.local_gas_station, color: Colors.white),
        Icon(Icons.account_balance_rounded, color: Colors.white),
      ],
    );
  }
}
