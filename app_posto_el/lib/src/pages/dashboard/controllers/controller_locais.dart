import 'dart:io';

import 'package:app_posto_el/src/pages/dashboard/controllers/locais_status.dart';
import 'package:app_posto_el/src/pages/dashboard/models/model_locais.dart';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'controller_locais.g.dart';

class ControllerLocais = _ControllerLocaisBase with _$ControllerLocais;

abstract class _ControllerLocaisBase with Store {
  @observable
  ObservableList<ModelLocais> locais = ObservableList.of([]);

  @observable
  int dropdownValue = 0;

  @observable
  LocaisStatus status = LocaisStatus.empty;

  @action
  Future<void> getLocais() async {
    try {
      status = LocaisStatus.loading;
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          var dio = Dio();
          final response = await dio
              .get('http://192.168.254.90:9000/empresa/01459027000100');

          final lista = response.data
              .map<ModelLocais>((elemento) => ModelLocais.fromMap(elemento))
              .toList();

          locais = ObservableList.of(lista);

          if (locais.isNotEmpty) {
            status = LocaisStatus.success;
          } else {
            status = LocaisStatus.error;
          }
        }
      } on SocketException catch (_) {
        status = LocaisStatus.semInternet;
      }
    } catch (e) {
      status = LocaisStatus.error;
      print('EU SOU O ERRO $e');
    }
  }
}
