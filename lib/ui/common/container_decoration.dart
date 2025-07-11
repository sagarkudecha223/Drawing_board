import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/dimens.dart';

class ContainerDecoration extends BoxDecoration {
  final double radius;
  final Color backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final List<BoxShadow>? boxShadows;
  final Gradient? gradientColor;

  ContainerDecoration({
    this.radius = Dimens.radiusMedium,
    this.backgroundColor = AppColors.white,
    this.borderColor,
    this.borderWidth = Dimens.borderWidthXSmall,
    this.boxShadows,
    this.gradientColor,
  }) : super(
         borderRadius: BorderRadius.circular(radius),
         color: backgroundColor,
         gradient: gradientColor,
         border: Border.all(
           width: borderWidth,
           color: borderColor ?? AppColors.borderColor,
         ),
         boxShadow: boxShadows,
       );
}
