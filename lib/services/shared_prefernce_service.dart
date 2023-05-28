import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static final PreferencesManager _instance = PreferencesManager._internal();
  static SharedPreferences? _sharedPreferences;

  factory PreferencesManager() {
    return _instance;
  }

  PreferencesManager._internal();

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  static PreferencesManager get instance => _instance;

  // Example method to get a boolean preference
  bool getBool(String key, {bool defaultValue = false}) {
    return _sharedPreferences?.getBool(key) ?? defaultValue;
  }

  // Example method to set a boolean preference
  Future<void> setBool(String key, bool value) async {
    await _sharedPreferences?.setBool(key, value);
  }

// Add more methods for other data types as needed (e.g., getInt, getString, setInt, setString, etc.)
}
