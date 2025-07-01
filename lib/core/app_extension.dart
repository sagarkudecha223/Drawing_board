import 'package:flutter/material.dart';
import 'colors.dart';
import 'enum.dart';
import 'images.dart';

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

extension DrawingModeExtension on DrawingMode {
  String get toolTip {
    switch (this) {
      case DrawingMode.paintMode:
        return 'Paint Mode';
      case DrawingMode.commentMode:
        return 'Comment Mode';
      case DrawingMode.addImageMode:
        return 'Add Image Mode';
      case DrawingMode.selectionMode:
        return 'Drag Mode';
    }
  }

  String get image {
    switch (this) {
      case DrawingMode.paintMode:
        return Images.pencil;
      case DrawingMode.commentMode:
        return Images.comment;
      case DrawingMode.addImageMode:
        return Images.imagesIcon;
      case DrawingMode.selectionMode:
        return Images.selection;
    }
  }
}
