import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  const Preferences();

  // Add your common preferences here.
}

/// Represents a singular preference.
abstract class Preference<T> {
  const Preference();

  Future<T?> load();
  Future<void> save(T? value);
}

class _SharedPref<T> extends Preference<T> {
  const _SharedPref(this.key);

  final String key;

  @override
  Future<T?> load() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final Object? value = sharedPreferences.get(key);
    if (value is T) {
      return value;
    }
    return null;
  }

  @override
  Future<void> save(T? value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (value == null) {
      // Removes the value from the preferences.
      await sharedPreferences.remove(key);
    } else if (value is bool) {
      await sharedPreferences.setBool(key, value);
    } else if (value is double) {
      await sharedPreferences.setDouble(key, value);
    } else if (value is int) {
      await sharedPreferences.setInt(key, value);
    } else if (value is String) {
      await sharedPreferences.setString(key, value);
    } else if (value is List<String>) {
      await sharedPreferences.setStringList(key, value);
    } else {
      throw UnsupportedError('The type $T is not supported');
    }
  }
}
