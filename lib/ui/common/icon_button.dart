import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/dimens.dart';
import 'app_loader.dart';
import 'svg_icon.dart';

class AppIconButton extends StatelessWidget {
  final String? svgImage;
  final Widget? iconWidget;
  final double? imageWidth;
  final double? imageHeight;
  final VoidCallback? onTap;
  final bool isLoading;
  final Color? disabledColor;
  final Color? imageColor;
  final Color? backgroundColor;
  final bool hasBorder;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final bool isEnabled;
  final Widget? loadingWidget;
  final VisualDensity? visualDensity;
  final double? elevation;
  final Color? shadowColor;
  final Size? fixedSize;

  const AppIconButton({
    super.key,
    this.svgImage,
    this.iconWidget,
    this.imageWidth,
    this.imageHeight,
    this.onTap,
    this.isLoading = false,
    this.disabledColor,
    this.backgroundColor = AppColors.transparent,
    this.hasBorder = false,
    this.imageColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.isEnabled = true,
    this.loadingWidget,
    this.visualDensity,
    this.elevation,
    this.shadowColor,
    this.fixedSize,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isLoading || !isEnabled ? null : onTap,
      visualDensity: visualDensity,
      style: IconButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: elevation,
        shadowColor: shadowColor,
        disabledBackgroundColor:
            isLoading
                ? AppColors.transparent
                : disabledColor ?? AppColors.secondaryGrey2,
        padding: const EdgeInsets.all(Dimens.padding3xSmall),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: borderColor ?? AppColors.borderColor,
            width: borderWidth ?? Dimens.borderWidthSmall,
            style:
                hasBorder || isLoading ? BorderStyle.solid : BorderStyle.none,
          ),
          borderRadius: BorderRadius.circular(
            borderRadius ?? Dimens.radius3xLarge,
          ),
        ),
        fixedSize: fixedSize ?? Size(Dimens.icon2xLarge, Dimens.icon2xLarge),
      ),
      icon:
          isLoading
              ? SizedBox(
                width: Dimens.iconXSmall,
                height: Dimens.iconXSmall,
                child: loadingWidget ?? const AppLoader(),
              )
              : IgnorePointer(
                child:
                    iconWidget ??
                    _SvgIcon(
                      image: svgImage!,
                      color: imageColor ?? AppColors.iconColor,
                      imageHeight: imageHeight ?? Dimens.iconMedium,
                      imageWidth: imageWidth ?? Dimens.iconMedium,
                    ),
              ),
    );
  }
}

class _SvgIcon extends StatelessWidget {
  final String image;
  final Color color;
  final double? imageWidth;
  final double? imageHeight;

  const _SvgIcon({
    required this.image,
    required this.color,
    this.imageWidth,
    this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return AppSvgIcon(
      image,
      color: color,
      height: imageHeight,
      width: imageWidth,
    );
  }
}
