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

  PaintTools get paintingTools;

  bool get paintingToolsVisible;
}

abstract class DrawingBoardEvent {}

class InitDrawingBoardEvent extends DrawingBoardEvent {}

class DrawingModeChangeEvent extends DrawingBoardEvent {
  final DrawingMode drawingMode;

  DrawingModeChangeEvent({required this.drawingMode});
}

class PaintingToolsChangeEvent extends DrawingBoardEvent {
  final PaintTools paintTools;

  PaintingToolsChangeEvent({required this.paintTools});
}

class UpdateDrawingBoardState extends DrawingBoardEvent {
  final DrawingBoardData state;

  UpdateDrawingBoardState(this.state);
}
