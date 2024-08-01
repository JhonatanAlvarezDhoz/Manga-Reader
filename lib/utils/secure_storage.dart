import 'package:shared_preferences/shared_preferences.dart';

/// La clase `SecureStorage` ahora usa `shared_preferences` para operaciones de almacenamiento de clave-valor.
class SecureStorage {
  /// Escribe un par clave-valor en `shared_preferences`.
  ///
  /// [key] La clave para el almacenamiento del valor.
  /// [value] El valor que se almacenará bajo la clave especificada.
  /// Esta operación es asíncrona.
  Future<void> writeSecureData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  /// Lee un valor de `shared_preferences` usando una clave.
  ///
  /// [key] La clave para leer el valor asociado.
  /// Devuelve el valor almacenado bajo la clave especificada, o `null` si no se encuentra.
  /// Esta operación es asíncrona.
  Future<String?> readSecureData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  /// Elimina un valor específico de `shared_preferences`.
  ///
  /// [key] La clave para el valor a eliminar.
  /// Esta operación es asíncrona.
  Future<void> deleteSecureData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  /// Lee todos los valores almacenados en `shared_preferences`.
  ///
  /// Devuelve un mapa con todos los pares clave-valor.
  /// Esta operación es asíncrona.
  Future<Map<String, dynamic>> readAll() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    final map = <String, dynamic>{};

    for (var key in keys) {
      map[key] = prefs.get(key);
    }

    return map;
  }

  /// Elimina todos los valores almacenados en `shared_preferences`.
  ///
  /// Esta operación es asíncrona.
  Future<void> deleteAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
