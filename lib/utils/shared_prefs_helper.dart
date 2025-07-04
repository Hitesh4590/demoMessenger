import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys {
  isFirstLogin('is_first_login');

  final String key;
  const PrefKeys(this.key);
}

class SharedPrefsHelper {
  // Set is_first_login value
  static Future<void> setFirstLogin(bool isFirstLogin) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefKeys.isFirstLogin.key, isFirstLogin);
  }

  // Get is_first_login value, defaults to true if not set
  static Future<bool> getFirstLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PrefKeys.isFirstLogin.key) ?? true;
  }
}