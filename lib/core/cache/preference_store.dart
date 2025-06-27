import 'package:shared_preferences/shared_preferences.dart';

import '../enum.dart';
import '../app_extension.dart';

class PreferenceStore {
  late SharedPreferences _sharedPreferences;

  PreferenceStore();

  Future<void> init() async =>
      _sharedPreferences = await SharedPreferences.getInstance();

  Future<void> resetValue() async {
    for (int index = 0; index < SharedPreferenceStore.values.length; index++) {
      await _sharedPreferences.remove(
        SharedPreferenceStore.values[index].preferenceKey,
      );
    }
  }

  Future<bool> setValue(SharedPreferenceStore value, dynamic data) async {
    switch (value.getRuntimeType) {
      case const (String):
        await _sharedPreferences.setString(value.name, data as String);
      case const (bool):
        await _sharedPreferences.setBool(value.name, data as bool);
      case const (int):
        await _sharedPreferences.setInt(value.name, data as int);
      case const (double):
        await _sharedPreferences.setDouble(value.name, data as double);
    }
    return true;
  }

  dynamic getValue(SharedPreferenceStore value) {
    switch (value.getRuntimeType) {
      case const (String):
        return _sharedPreferences.getString(value.name);
      case const (bool):
        return _sharedPreferences.getBool(value.name);
      case const (int):
        return _sharedPreferences.getInt(value.name);
      case const (double):
        return _sharedPreferences.getDouble(value.name);
    }
  }
}
