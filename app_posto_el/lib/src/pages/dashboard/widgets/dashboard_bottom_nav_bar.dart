import 'package:app_posto_el/src/theme/app_theme.dart';
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
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            widget.onChanged(index);
          });
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
    );
  }
}
