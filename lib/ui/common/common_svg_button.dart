import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/dimens.dart';
import 'icon_button.dart';
import 'svg_icon.dart';

class CommonIconButton extends StatelessWidget {
  final Color backgroundColor;
  final String svgIcon;
  final Function() onTap;

  const CommonIconButton({
    super.key,
    required this.backgroundColor,
    required this.svgIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      backgroundColor: backgroundColor,
      hasBorder: true,
      borderColor: AppColors.borderColor,
      iconWidget: AppSvgIcon(
        svgIcon,
        color: AppColors.white,
        height: Dimens.iconSmall,
      ),
      onTap: onTap,
    );
  }
}
