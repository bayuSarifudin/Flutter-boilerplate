import 'package:shared_preferences/shared_preferences.dart';

/// Layanan terpusat untuk menyimpan pengaturan/preferensi ringan aplikasi.
class PreferencesService {
  final SharedPreferences _prefs;

  PreferencesService(this._prefs);

  Future<bool> setString(String key, String value) async =>
      await _prefs.setString(key, value);

  String? getString(String key) => _prefs.getString(key);

  Future<bool> setBool(String key, bool value) async =>
      await _prefs.setBool(key, value);

  bool? getBool(String key) => _prefs.getBool(key);

  Future<bool> remove(String key) async => await _prefs.remove(key);

  Future<bool> clear() async => await _prefs.clear();
}
