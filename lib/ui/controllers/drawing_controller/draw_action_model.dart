import 'package:flutter/material.dart';

import '../../../core/enum.dart';

class DrawActionModel {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;
  final PaintTools shape;
  String? text;
  double? width;
  double? height;
  final String? svgAsset;

  DrawActionModel({
    required this.points,
    required this.color,
    required this.strokeWidth,
    required this.shape,
    this.text,
    this.width,
    this.height,
    this.svgAsset,
  });
}
