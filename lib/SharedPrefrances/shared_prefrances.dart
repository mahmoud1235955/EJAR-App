import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences sharedPreferences;
  static initial() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static Future<bool> storeData({
    required String key,
    required dynamic value,
  }) async {
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else {
      return await sharedPreferences.setStringList(key, value);
    }
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  static Future<bool> clearData() {
    return sharedPreferences.clear();
  }

  static Future<bool> containKey({required String key}) async {
    return sharedPreferences.containsKey(key);
  }
}
