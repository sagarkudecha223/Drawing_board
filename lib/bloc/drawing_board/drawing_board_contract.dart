import 'package:flutter/material.dart' as material;
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';

import '../../core/enum.dart';
import '../../ui/controllers/drawing_controller/drawing_controller.dart';

part 'drawing_board_contract.g.dart';

abstract class DrawingBoardData
    implements Built<DrawingBoardData, DrawingBoardDataBuilder> {
  factory DrawingBoardData([void Function(DrawingBoardDataBuilder) updates]) =
      _$DrawingBoardData;

  DrawingBoardData._();

  CustomDrawingController get drawingController;

  DrawingMode get drawingMode;

  PaintingTools get paintingTools;

  bool get paintingToolsVisible;

  SvgImageOptions get selectedSvgImage;

  bool get svgOptionsVisible;

  material.Color get selectedColor;
}

abstract class DrawingBoardEvent {}

class InitDrawingBoardEvent extends DrawingBoardEvent {}

class DrawingModeChangeEvent extends DrawingBoardEvent {
  final DrawingMode drawingMode;

  DrawingModeChangeEvent({required this.drawingMode});
}

class PaintingToolsChangeEvent extends DrawingBoardEvent {
  final PaintingTools paintTools;

  PaintingToolsChangeEvent({required this.paintTools});
}

class SvgChangeEvent extends DrawingBoardEvent {
  final SvgImageOptions svgImageOptions;

  SvgChangeEvent({required this.svgImageOptions});
}

class UpdateDrawingBoardState extends DrawingBoardEvent {
  final DrawingBoardData state;

  UpdateDrawingBoardState(this.state);
}
