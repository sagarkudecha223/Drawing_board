import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/dimens.dart';
import 'icon_button.dart';

class CommonIconButton extends StatelessWidget {
  final Color? backgroundColor;
  final String svgIcon;
  final Function() onTap;
  final bool isSelected;

  const CommonIconButton({
    super.key,
    this.backgroundColor,
    required this.svgIcon,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      backgroundColor:
          isSelected
              ? AppColors.selectedIconBackgroundColor
              : backgroundColor ?? AppColors.backgroundColor,
      hasBorder: true,
      borderRadius: Dimens.radiusMedium,
      borderColor: AppColors.borderColor,
      elevation: Dimens.elevationSmall,
      shadowColor: AppColors.shadowColor,
      svgImage: svgIcon,
      imageColor:
          isSelected ? AppColors.selectedIconColor : AppColors.iconColor,
      onTap: onTap,
    );
  }
}
