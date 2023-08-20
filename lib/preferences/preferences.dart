import 'package:shared_preferences/shared_preferences.dart';

/// Clase que gestiona datos guardados en local (preferencias)
class Preferences {
  /// Instancia de las SharedPreferences
  static late SharedPreferences _preferencesInstance;

  /// Función que inicializa las SharedPreferences
  static Future<void> initialize() async => _preferencesInstance = await SharedPreferences.getInstance();

  /// Guarda un elemento en las SharedPreferences
  static Future<bool> setItem<T>(String key, T value) async {
    if (T == String) return await _setStringItem(key, value as String);

    if (T == bool) return await _setBoolItem(key, value as bool);

    return false;
  }

  /// Obtiene un elemento de las ShardPreferences
  static T? getItem<T>(String key) {
    if (T == String) return _getStringItem(key) as T?;

    if (T == bool) return _getBoolItem(key) as T?;

    return null;
  }

  /// Elimina un elemento de las SharedPreferences
  static Future<bool> removeItem(String key) async {
    return await _preferencesInstance.remove(key);
  }

  static Future<bool> _setStringItem(String key, String value) async => await _preferencesInstance.setString(key, value);

  static String? _getStringItem(String key) => _preferencesInstance.getString(key);

  static Future<bool> _setBoolItem(String key, bool value) async => await _preferencesInstance.setBool(key, value);

  static bool? _getBoolItem(String key) => _preferencesInstance.getBool(key);
}
