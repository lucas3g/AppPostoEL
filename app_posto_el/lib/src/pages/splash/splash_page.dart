import 'dart:io';

import 'package:app_posto_el/src/configs/app_settings.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void verificaInternet() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        inicializar();
      }
    } on SocketException catch (_) {
      GetIt.I.get<AppSettigns>().removeLogado();
      BotToast.showText(
        text: 'Celular sem Internet. Verifique sua Conexão.',
        contentColor: Color(0xFFFF7F26),
        duration: Duration(seconds: 3),
      );
      Navigator.popAndPushNamed(context, '/login');
      return;
    }
  }

  void inicializar() async {
    await Future.delayed(Duration(seconds: 2));
    if (await GetIt.I.get<AppSettigns>().logado['conectado'] == 'N') {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  @override
  void initState() {
    verificaInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: AppTheme.colors.backgroundPrimary),
        child: SafeArea(
          top: true,
          bottom: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 24),
                  Row(
                    children: [
                      SizedBox(height: 60),
                      Opacity(
                        opacity: 0.5,
                        child: Image.asset(
                          'assets/images/barra-direita.png',
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Container(
                height: 78,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('E',
                        style: AppTheme.textStyles.titleLogin
                            .copyWith(fontSize: 70)),
                    Text('L',
                        style: AppTheme.textStyles.titleLogin
                            .copyWith(fontSize: 70)),
                    Text(
                      ' Sistemas',
                      style: AppTheme.textStyles.titleLogin.copyWith(
                        color: Color(0xFF525252),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Opacity(
                        opacity: 0.5,
                        child: Image.asset(
                          'assets/images/barra-esquerda.png',
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
