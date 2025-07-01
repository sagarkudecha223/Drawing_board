import 'dart:ui';

import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';

import '../../ui/controllers/drawing_controller/drawing_controller.dart';

part 'drawing_board_contract.g.dart';

abstract class DrawingBoardData
    implements Built<DrawingBoardData, DrawingBoardDataBuilder> {
  factory DrawingBoardData([void Function(DrawingBoardDataBuilder) updates]) =
      _$DrawingBoardData;

  DrawingBoardData._();

  CustomDrawingController get drawingController;
}

abstract class DrawingBoardEvent {}

class InitDrawingBoardEvent extends DrawingBoardEvent {}

class UpdateDrawingBoardState extends DrawingBoardEvent {
  final DrawingBoardData state;

  UpdateDrawingBoardState(this.state);
}
