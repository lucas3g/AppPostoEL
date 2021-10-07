import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettigns extends ChangeNotifier {
  late SharedPreferences _prefs;

  Map<String, String> logado = {'conectado': 'N'};
  Map<String, String> cnpj = {'cnpj': ''};

  AppSettigns() {
    _startSettings();
  }

  _startSettings() async {
    await _startPreferences();
    await _readLogado();
    await _readUser();
  }

  Future<void> _startPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  _readLogado() {
    final logadoApp = _prefs.getString('conectado') ?? 'N';

    logado = {'conectado': logadoApp};

    notifyListeners();
  }

  _readUser() {
    final cnpjApp = _prefs.getString('cnpj') ?? '';

    cnpj = {'cnpj': cnpjApp};

    notifyListeners();
  }

  setLogado({required String conectado}) async {
    await _prefs.setString('conectado', conectado);

    await _readLogado();
  }

  setUser({required String cnpj}) async {
    await _prefs.setString('cnpj', cnpj);

    await _readUser();
  }

  removeLogado() async {
    await _prefs.remove('conectado');
    await _prefs.remove('cnpj');
    await _readLogado();
  }
}
