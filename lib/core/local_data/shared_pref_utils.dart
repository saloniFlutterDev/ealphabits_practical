import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/login_screen/model/local_user_model.dart';

class SharedPreferenceUtils {

  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  static const _tokenKey = 'auth_token';
  static const _userKey = 'local_user';
  static const _rememberKey = 'remember_me';

  /// Save token
  static Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// Save user model
  static Future<void> setUser(LocalUserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  static Future<LocalUserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson == null) return null;
    return LocalUserModel.fromJson(jsonDecode(userJson));
  }

  /// Save remember me flag
  static Future<void> setRemember(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberKey, value);
  }

  static Future<bool> getRemember() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_rememberKey) ?? false;
  }

  /// Clear all stored data (for logout)
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // static String getLoggedIn() {
  //   return _prefsInstance?.getString("isLoggedIn") ?? "";
  // }
  //
  // static Future<bool> setLoggedIn(String value) async {
  //   var prefs = await _instance;
  //   return prefs.setString("isLoggedIn", value);
  // }
}
