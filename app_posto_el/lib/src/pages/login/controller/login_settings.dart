import 'package:shared_preferences/shared_preferences.dart';

class LoginSettings {
  Future<SharedPreferences> _preferences = SharedPreferences.getInstance();

  Future<void> getInstance() async {
    SharedPreferences preferences = await _preferences;
  }
}
