import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';

import '../../core/enum.dart';
import '../../ui/controllers/drawing_controller/drawing_controller.dart';

part 'bottom_drawing_controller_contract.g.dart';

abstract class BottomDrawingControllerData
    implements
        Built<BottomDrawingControllerData, BottomDrawingControllerDataBuilder> {
  factory BottomDrawingControllerData([
    void Function(BottomDrawingControllerDataBuilder) updates,
  ]) = _$BottomDrawingControllerData;

  BottomDrawingControllerData._();

  CustomDrawingController get customDrawingController;
}

abstract class BottomDrawingControllerEvent {}

class InitBottomDrawingControllerEvent extends BottomDrawingControllerEvent {
  final CustomDrawingController customDrawingController;

  InitBottomDrawingControllerEvent({required this.customDrawingController});
}

class UpdateDrawingEvent extends BottomDrawingControllerEvent {
  final DrawingToolEnum drawingToolEnum;

  UpdateDrawingEvent({required this.drawingToolEnum});
}

class UpdateBottomDrawingControllerState extends BottomDrawingControllerEvent {
  final BottomDrawingControllerData state;

  UpdateBottomDrawingControllerState(this.state);
}
