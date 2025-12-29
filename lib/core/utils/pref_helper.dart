import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static final String tokenKey = 'auth_token';
  static Future<void> saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(tokenKey, token);
  }

  static Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString(tokenKey);
    return token;
  }

  static Future<void> removeToken() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(tokenKey);
  }
}
