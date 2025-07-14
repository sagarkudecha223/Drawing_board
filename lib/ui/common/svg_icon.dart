import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSvgIcon extends StatelessWidget {
  final String assetName;
  final double? width;
  final double? height;
  final Color? color;
  final BlendMode blendMode;
  final BoxFit fit;
  final bool matchTextDirection;
  final bool allowDrawingOutsideViewBox;
  final Clip clipBehavior;

  const AppSvgIcon(
    this.assetName, {
    super.key,
    this.width,
    this.height,
    this.color,
    this.blendMode = BlendMode.srcIn,
    this.fit = BoxFit.contain,
    this.matchTextDirection = false,
    this.allowDrawingOutsideViewBox = false,
    this.clipBehavior = Clip.hardEdge,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      color: color,
      matchTextDirection: matchTextDirection,
      fit: fit,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      clipBehavior: clipBehavior,
    );
  }
}
