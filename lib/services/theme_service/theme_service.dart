import 'dart:async';

import '../../core/cache/preference_store.dart';
import '../../core/colors.dart';
import '../../core/enum.dart';

class ThemeService {
  ThemeService(this._preferenceStore);

  final PreferenceStore _preferenceStore;

  final _themeChanged = StreamController<bool>.broadcast();

  Stream<bool> notifyThemeChange() => _themeChanged.stream;

  void changeThemeMode() {
    final isLightTheme = _changeTheme();
    _themeChanged.add(isLightTheme);
  }

  bool getThemeMode() {
    AppColors.isLightTheme =
        _preferenceStore.getValue(SharedPreferenceStore.IS_LIGHT_THEME_MODE) ??
        false;
    return AppColors.isLightTheme;
  }

  bool _changeTheme() {
    _preferenceStore.setValue(
      SharedPreferenceStore.IS_LIGHT_THEME_MODE,
      !AppColors.isLightTheme,
    );
    AppColors.isLightTheme = !AppColors.isLightTheme;
    return AppColors.isLightTheme;
  }
}
