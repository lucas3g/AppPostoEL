import 'package:app_posto_el/src/pages/dashboard/dashboard_page_widget.dart';
import 'package:app_posto_el/src/pages/login/login_page_widget.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Split.it',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPageWidiget(),
        '/dashboard': (context) => DashBoardPageWidget()
      },
    );
  }
}
