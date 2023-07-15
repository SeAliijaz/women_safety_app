import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static SharedPreferences? sharedPreferences;
  static const String key = "usertype";

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  static Future saveUserType(String type) async {
    return await sharedPreferences!.setString(key, type);
  }

  static Future<String>? getUserType() async =>
      await sharedPreferences!.getString(key) ?? "";
}
