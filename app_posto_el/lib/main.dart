import 'dart:async';

import 'package:app_posto_el/app_widget.dart';
import 'package:app_posto_el/src/configs/app_settings.dart';
import 'package:app_posto_el/src/pages/dashboard/controllers/controller_locais.dart';
import 'package:app_posto_el/src/pages/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      GetIt getIt = GetIt.I;
      getIt.registerSingleton<AppSettigns>(AppSettigns(), signalsReady: true);
      getIt.registerSingleton<ControllerLocais>(ControllerLocais(),
          signalsReady: true);
      getIt.registerSingleton<LoginController>(LoginController());
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // status bar color
      ));
      runApp(AppWidget());
    },
    (error, st) => print(error),
  );
}
