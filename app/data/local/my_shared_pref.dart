import 'package:shared_preferences/shared_preferences.dart';

class MySharedPref {
  // prevent making instance
  MySharedPref._();

  // get storage
  static late SharedPreferences _sharedPreferences;

  // STORING KEYS
  static const String _fcmTokenKey = 'fcm_token';
  static const String _lightThemeKey = 'is_theme_light';

  /// init get storage services
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static setStorage(SharedPreferences sharedPreferences) {
    _sharedPreferences = sharedPreferences;
  }

  /// set theme current type as light theme
  static Future<void> setThemeIsLight(bool lightTheme) =>
      _sharedPreferences.setBool(_lightThemeKey, lightTheme);

  /// get if the current theme type is light
  static bool getThemeIsLight() =>
      _sharedPreferences.getBool(_lightThemeKey) ?? false; // todo set the default theme (true for light, false for dark)

  /// save generated fcm token
  static Future<void> setFcmToken(String token) =>
      _sharedPreferences.setString(_fcmTokenKey, token);

  /// get generated fcm token
  static String? getFcmToken() =>
      _sharedPreferences.getString(_fcmTokenKey);

  /// clear all data from shared pref
  static Future<void> clear() async => await _sharedPreferences.clear();

  static List<String> getList(String key) {
    return _sharedPreferences.getStringList(key) ?? [];
  }

  static Future<void> addToList(String key, String value) async {
    List<String> val = getList(key);
    val.add(value);
    _sharedPreferences.setStringList(key, val);
  }

  static int getTotal() {
    return _sharedPreferences.getInt('total') ?? 0;
  }

  static Future<void> setTotal(int value) async {
    _sharedPreferences.setInt('total', value);
  }

  static Future<void> setPremium(bool value) async{
    _sharedPreferences.setBool('premium', value);
  }

  static bool getPremium() {
    return _sharedPreferences.getBool('premium') ?? false;
  }

}