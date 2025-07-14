import 'package:flutter/material.dart' as material;
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';

import '../../core/enum.dart';
import '../../ui/controllers/comment_mode/comment_model.dart';
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

  SvgImageOptions get selectedSvgImage;

  material.Color get selectedColor;

  List<CommentModel> get listOfComments;

  material.Offset? get commentPosition;

  material.TextEditingController get commentController;

  bool get isCustomColorDialogShow;

  int get alpha;
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

class AddCommentEvent extends DrawingBoardEvent {}

class OutSideTapEvent extends DrawingBoardEvent {}

class ShowAddCommentEvent extends DrawingBoardEvent {
  final material.TapUpDetails tapUpDetails;

  ShowAddCommentEvent({required this.tapUpDetails});
}

class DeleteCommentEvent extends DrawingBoardEvent {
  final CommentModel commentModel;

  DeleteCommentEvent({required this.commentModel});
}

class CustomColorDialogShowEvent extends DrawingBoardEvent {}

class ColorChangeEvent extends DrawingBoardEvent {
  final material.Color color;

  ColorChangeEvent({required this.color});
}

class AlphaChangeEvent extends DrawingBoardEvent {
  final int value;

  AlphaChangeEvent({required this.value});
}

class UpdateDrawingBoardState extends DrawingBoardEvent {
  final DrawingBoardData state;

  UpdateDrawingBoardState(this.state);
}
