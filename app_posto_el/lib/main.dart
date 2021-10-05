import 'dart:async';

import 'package:app_posto_el/app_widget.dart';
import 'package:app_posto_el/src/configs/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      GetIt getIt = GetIt.I;
      getIt.registerSingleton<AppSettigns>(AppSettigns(), signalsReady: true);

      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // status bar color
      ));
      runApp(AppWidget());
    },
    (error, st) => print(error),
  );
}
