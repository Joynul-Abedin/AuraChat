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
  bool getIsLoggedIn(String key, {bool defaultValue = false}) {
    return _sharedPreferences?.getBool(key) ?? defaultValue;
  }

  // Example method to set a boolean preference
  Future<void> setIsLoggedIn(String key, bool value) async {
    await _sharedPreferences?.setBool(key, value);
  }

  String getName(String key, {String defaultValue = ""}) {
    return _sharedPreferences?.getString(key) ?? defaultValue;
  }

  // Example method to set a boolean preference
  Future<void> setName(String key, String value) async {
    await _sharedPreferences?.setString(key, value);
  }

  String getImage(String key, {String defaultValue = ""}) {
    return _sharedPreferences?.getString(key) ?? defaultValue;
  }

  // Example method to set a boolean preference
  Future<void> setImage(String key, String value) async {
    await _sharedPreferences?.setString(key, value);
  }

  String getID(String key, {String defaultValue = ""}) {
    return _sharedPreferences?.getString(key) ?? defaultValue;
  }

  // Example method to set a boolean preference
  Future<void> setID(String key, String value) async {
    await _sharedPreferences?.setString(key, value);
  }

  // Method to clear all stored preferences
  Future<void> clearAll() async {
    await _sharedPreferences?.clear();
  }

// Add more methods for other data types as needed (e.g., getInt, getString, setInt, setString, etc.)
}
