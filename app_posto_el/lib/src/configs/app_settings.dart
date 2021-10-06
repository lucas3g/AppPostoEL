import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettigns extends ChangeNotifier {
  late SharedPreferences _prefs;

  Map<String, String> logado = {'conectado': 'N'};

  AppSettigns() {
    _startSettings();
  }

  _startSettings() async {
    await _startPreferences();
    await _readLogado();
  }

  Future<void> _startPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  _readLogado() {
    final logadoApp = _prefs.getString('conectado') ?? 'N';

    logado = {'conectado': logadoApp};

    notifyListeners();
  }

  setLogado({required String conectado}) async {
    await _prefs.setString('conectado', conectado);

    await _readLogado();
  }

  removeLogado() async {
    await _prefs.remove('conectado');

    await _readLogado();
  }
}
