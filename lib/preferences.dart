import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _preferences = Preferences._preferences;
  static const masterLat = 'masterLat';
  static const masterLong = 'masterLong';

  factory Preferences() {
    return _preferences;
  }

  static Future<bool> setDouble(String key, double value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setDouble(key, value);
  }

  static Future<double?> getDouble(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(key);
  }
}
