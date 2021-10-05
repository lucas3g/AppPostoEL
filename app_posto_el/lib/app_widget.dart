import 'package:app_posto_el/src/configs/app_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/dashboard_page_widget.dart';
import 'package:app_posto_el/src/pages/login/login_page_widget.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Split.it',
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      initialRoute: GetIt.I.get<AppSettigns>().logado['conectado'] == 'N'
          ? '/login'
          : '/dashboard',
      routes: {
        '/login': (context) => LoginPageWidiget(),
        '/dashboard': (context) => DashBoardPageWidget()
      },
    );
  }
}
