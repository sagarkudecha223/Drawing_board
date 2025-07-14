import 'package:flutter/material.dart';

class AppColors {
  static bool isLightTheme = false;

  // Primary brand color
  static const Color primaryBlue1 = Color(0xFF254D99);
  static const Color primaryBlue2 = Color(0xFF549DD6);
  static const Color pastelBlue = Color(0xFFA3C8F0);
  static const Color mutedPeach = Color(0xFFF6C5B2);
  static const Color secondary = Color(0xFF03DAC6);

  // Light theme
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightOnSurface = Color(0xFF000000);
  static const Color lightTextHigh = Color(0xDE000000);
  static const Color lightTextMedium = Color(0x99000000);
  static const Color lightTextDisabled = Color(0x61000000);

  // Dark theme
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkOnPrimary = Color(0xFF000000);
  static const Color darkOnSurface = Color(0xFFFFFFFF);
  static const Color darkTextHigh = Color(0xDEFFFFFF);
  static const Color darkTextMedium = Color(0x99FFFFFF);
  static const Color darkTextDisabled = Color(0x61FFFFFF);

  // Error
  static const Color error = Color(0xFFCF6679);

  static const transparent = Colors.transparent;
  static const Color secondaryGrey1 = Color(0xFFD3D3D3);
  static const Color secondaryGrey2 = Color(0xFFCCCCCC);
  static const Color white = Color(0xFFFFFFFF);

  static const Color lightRed = Color(0xFFF85C5C);
  static const Color red = Color(0xFFC82333);

  static Color get iconColor =>
      isLightTheme ? AppColors.darkSurface : AppColors.lightSurface;

  static Color get textColor =>
      isLightTheme ? AppColors.lightTextHigh : AppColors.darkTextHigh;

  static Color get boldTextColor =>
      isLightTheme ? AppColors.lightTextDisabled : AppColors.darkTextDisabled;

  static Color get borderColor =>
      isLightTheme ? lightTextMedium : darkTextMedium;

  static Color get backgroundColor => isLightTheme ? lightSurface : darkSurface;

  static Color get selectedIconColor =>
      isLightTheme ? lightBackground : darkBackground;

  static Color get selectedIconBackgroundColor =>
      isLightTheme ? lightTextMedium : darkTextMedium;

  static Color get shadowColor =>
      isLightTheme ? lightTextDisabled : darkTextMedium;
}
