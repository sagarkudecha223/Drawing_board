import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../core/dimens.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryBlue1,
      secondary: AppColors.secondary,
      surface: AppColors.lightSurface,
      onPrimary: AppColors.lightOnPrimary,
      onSurface: AppColors.lightOnSurface,
      error: AppColors.error,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors.lightBackground,
    shadowColor: AppColors.darkTextHigh,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.lightTextHigh),
      bodyMedium: TextStyle(color: AppColors.lightTextMedium),
      bodySmall: TextStyle(color: AppColors.lightTextDisabled),
    ),
    cardTheme: CardTheme(
      shadowColor: AppColors.darkBackground,
      color: AppColors.lightTextDisabled,
      elevation: Dimens.elevationMedium,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.radius4xLarge),
        side: BorderSide(color: AppColors.lightTextMedium),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryBlue1,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryBlue1,
      secondary: AppColors.secondary,
      surface: AppColors.darkSurface,
      onPrimary: AppColors.darkOnPrimary,
      onSurface: AppColors.darkOnSurface,
      error: AppColors.error,
      onError: Colors.black,
    ),
    shadowColor: AppColors.lightTextHigh,
    cardTheme: CardTheme(
      shadowColor: AppColors.lightBackground,
      elevation: Dimens.elevationMedium,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.radius4xLarge),
        side: BorderSide(color: AppColors.darkTextMedium),
      ),
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkTextHigh),
      bodyMedium: TextStyle(color: AppColors.darkTextMedium),
      bodySmall: TextStyle(color: AppColors.darkTextDisabled),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      foregroundColor: AppColors.darkTextHigh,
      elevation: 0,
    ),
  );
}
