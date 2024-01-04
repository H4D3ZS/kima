import 'package:shared_preferences/shared_preferences.dart';
import 'package:kima/src/utils/helpers/print_helpers.dart';

/// *************** REMOVE SharedPref
Future<void> removeSharedPref(String key) async {
// Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

// Remove data for the key.
  await prefs.remove(key);
  printDebug(key, title: 'SharedPref Removed');
}

/// *************** SET SharedPref
Future<void> setIntSharedPref(String key, int value) async {
// Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

// Save an integer value to key.
  await prefs.setInt(key, value);
  printDebug(value, title: 'SharedPref Set $key');
}

Future<void> setBoolSharedPref(String key, bool value) async {
// Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

// Save an boolean value to key.
  await prefs.setBool(key, value);
  printDebug(value, title: 'SharedPref Set $key');
}

Future<void> setDoubleSharedPref(String key, double value) async {
// Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

// Save an double value to key.
  await prefs.setDouble(key, value);
  printDebug(value, title: 'SharedPref Set $key');
}

Future<void> setStringSharedPref(String key, String value) async {
// Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

// Save an String value to key.
  await prefs.setString(key, value);
  printDebug(value, title: 'SharedPref Set $key');
}

Future<void> setStringListSharedPref(String key, List<String> value) async {
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

// Save an list of strings to key.
  await prefs.setStringList(key, value);
  printDebug(value, title: 'SharedPref Set $key');
}

/// *************** READ SharedPref
Future<int?> readIntSharedPref(String key) async {
// Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

// Try reading data from the 'counter' key. If it doesn't exist, returns null.
  final int? value = prefs.getInt(key);

// return value of key.
  printDebug(value, title: 'SharedPref Read $key');
  return value;
}

Future<bool?> readBoolSharedPref(String key) async {
// Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

// Try reading data from the 'repeat' key. If it doesn't exist, returns null.
  final bool? value = prefs.getBool(key);

// return value of key.
  printDebug(value, title: 'SharedPref Read $key');
  return value;
}

Future<double?> readDoubleSharedPref(String key) async {
// Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

// Try reading data from the 'decimal' key. If it doesn't exist, returns null.
  final double? value = prefs.getDouble(key);

// return value of key.
  printDebug(value, title: 'SharedPref Read $key');
  return value;
}

Future<String?> readStringSharedPref(String key) async {
// Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

// Try reading data from the 'action' key. If it doesn't exist, returns null.
  final String? value = prefs.getString(key);

// return value of key.
  printDebug(value, title: 'SharedPref Read $key');
  return value;
}

Future<List<String>?> readStringListSharedPref(String key) async {
// Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

// Try reading data from the 'items' key. If it doesn't exist, returns null.
  final List<String>? value = prefs.getStringList(key);

// return value of key.
  printDebug(value, title: 'SharedPref Read $key');
  return value;
}
