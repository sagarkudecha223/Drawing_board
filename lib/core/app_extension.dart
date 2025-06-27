import 'package:flutter/material.dart';
import 'colors.dart';
import 'enum.dart';

extension AppLoaderThemeColor on AppLoaderTheme {
  Color get backgroundColor {
    switch (this) {
      case AppLoaderTheme.light:
        return AppColors.primary;
      case AppLoaderTheme.dark:
        return AppColors.secondary;
    }
  }

  Color get valueColor {
    switch (this) {
      case AppLoaderTheme.light:
        return AppColors.lightBackground;
      case AppLoaderTheme.dark:
        return AppColors.darkBackground;
    }
  }
}

extension SharedPreferenceStoreExtractor on SharedPreferenceStore {
  String get preferenceKey => name;

  Type get getRuntimeType {
    switch (this) {
      case SharedPreferenceStore.IS_LIGHT_THEME_MODE:
        return bool;
    }
  }
}
