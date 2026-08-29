import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/AppConst/app_const.dart';

class SharedPreferencesHelper {
  final SharedPreferences prefs;

  SharedPreferencesHelper({required this.prefs});

  Future<bool> saveToken(String token) async {
    return await prefs.setString(AppConst.tokenKey, token);
  }

  Future<String?> getToken() async {
    return prefs.getString(AppConst.tokenKey);
  }

  Future<bool> clearUserSession() async {
    return await prefs.remove(AppConst.tokenKey);
  }

  Future<bool> setBool(String key, bool value) async {
    return await prefs.setBool(key, value);
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return prefs.getBool(key) ?? defaultValue;
  }
}
