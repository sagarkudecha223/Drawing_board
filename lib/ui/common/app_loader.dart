import 'package:flutter/material.dart';
import '../../core/app_extension.dart';
import '../../core/dimens.dart';
import '../../core/enum.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({
    super.key,
    this.theme = AppLoaderTheme.dark,
    this.strokeWidth,
    this.backgroundColor,
  });

  final AppLoaderTheme theme;
  final double? strokeWidth;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth ?? Dimens.borderWidthXMedium,
        valueColor:
            AlwaysStoppedAnimation<Color>(backgroundColor ?? theme.valueColor),
        backgroundColor: theme.backgroundColor.withOpacity(0.2),
      ),
    );
  }
}
