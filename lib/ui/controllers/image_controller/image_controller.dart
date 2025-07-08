import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../drawing_controller/draw_action_model.dart';
import '../drawing_controller/drawing_controller.dart';

class ImageDrawWidget extends StatelessWidget {
  final CustomDrawingController controller;
  final Color svgColor;

  const ImageDrawWidget({
    super.key,
    required this.controller,
    required this.svgColor,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<DrawActionModel>>(
      valueListenable: controller,
      builder: (context, drawActions, child) {
        return Stack(
          children:
              drawActions.map((action) {
                if (action.svgAsset != null && action.points.length > 1) {
                  final rect = Rect.fromPoints(
                    action.points[0],
                    action.points[1],
                  );
                  return Positioned(
                    left: rect.left,
                    top: rect.top,
                    width: rect.width,
                    height: rect.height,
                    child: SvgPicture.asset(
                      action.svgAsset!,
                      fit: BoxFit.contain,
                      color: svgColor,
                    ),
                  );
                }
                return Container();
              }).toList(),
        );
      },
    );
  }
}
