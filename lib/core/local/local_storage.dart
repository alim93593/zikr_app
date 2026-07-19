import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Simple wrapper around SharedPreferences and FlutterSecureStorage.
class LocalStorage {
  final SharedPreferences _prefs;
  final FlutterSecureStorage _secure;

  LocalStorage._(this._prefs, this._secure);

  static Future<LocalStorage> init() async {
    final prefs = await SharedPreferences.getInstance();
    final secure = const FlutterSecureStorage();
    return LocalStorage._(prefs, secure);
  }

  // Shared preferences (non-sensitive)
  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);
  String? getString(String key) => _prefs.getString(key);
  Future<bool> removeString(String key) => _prefs.remove(key);

  // Secure storage (sensitive)
  Future<void> setSecure(String key, String value) =>
      _secure.write(key: key, value: value);
  Future<String?> getSecure(String key) => _secure.read(key: key);
  Future<void> removeSecure(String key) => _secure.delete(key: key);
}
