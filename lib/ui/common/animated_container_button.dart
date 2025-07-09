import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/dimens.dart';
import 'svg_icon.dart';

class AnimatedContainerButton extends StatelessWidget {
  final String svgIcon;
  final Function() onTap;
  final bool isSelected;

  const AnimatedContainerButton({
    super.key,
    required this.svgIcon,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.all(Radius.circular(Dimens.radiusMedium)),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        padding: EdgeInsets.all(Dimens.space3xSmall),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.radiusMedium)),
          color: AppColors.transparent,
          border: Border.all(color: AppColors.transparent),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              color: isSelected ? AppColors.secondary : AppColors.shadowColor,
              blurRadius: isSelected ? 8 : 5,
            ),
          ],
        ),
        child: AppSvgIcon(
          svgIcon,
          height: Dimens.iconXMedium,
          width: Dimens.iconXMedium,
          color: isSelected ? AppColors.secondary : AppColors.iconColor,
        ),
      ),
    );
  }
}
