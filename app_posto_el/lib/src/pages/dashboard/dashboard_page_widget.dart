import 'package:flutter/material.dart';

class DashBoardPageWidget extends StatefulWidget {
  DashBoardPageWidget({Key key}) : super(key: key);

  @override
  State<DashBoardPageWidget> createState() => _DashBoardPageWidgetState();
}

class _DashBoardPageWidgetState extends State<DashBoardPageWidget> {
  int _currentIndex = 0;
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
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _currentIndex = index;
          setState(() {});
        },
        selectedLabelStyle: TextStyle(
          color: Colors.black87,
          fontSize: 16,
        ),
        backgroundColor: Color(0xffcf1f36),
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

  PreferredSizeWidget _appBar() {
    return PreferredSize(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        child: AppBar(
          centerTitle: true,
          leading: Container(),
          backgroundColor: Color(0xffcf1f36),
          title: Text('Vendas'),
        ),
      ),
      preferredSize: Size.fromHeight(65),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: pages[_currentIndex],
      bottomNavigationBar: _bottomNavBar(),
    );
  }
}
