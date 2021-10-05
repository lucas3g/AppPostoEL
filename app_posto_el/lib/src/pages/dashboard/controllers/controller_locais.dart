import 'package:app_posto_el/src/pages/dashboard/models/model_locais.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
part 'controller_locais.g.dart';

class ControllerLocais = _ControllerLocaisBase with _$ControllerLocais;

abstract class _ControllerLocaisBase with Store {
  @observable
  ModelLocais locais = ModelLocais();

  @action
  void onChanged({int? id, String? descricao}) {
    locais = locais.copyWith(id: id, descricao: descricao);
  }

  @action
  Future<void> getLocais() async {
    try {
      var dio = Dio();
      final response =
          await dio.get('http://192.168.254.90:9000/empresa/01459027000100');
      onChanged(id: response.data['ID'], descricao: response.data['DESCRICAO']);
    } catch (e) {
      print('EU SOU O ERRO $e');
    }
  }
}
