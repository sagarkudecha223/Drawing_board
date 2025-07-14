import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';

import '../../core/enum.dart';
import '../../ui/controllers/drawing_controller/drawing_controller.dart';
import 'bottom_drawing_controller_contract.dart';

class BottomDrawingControllerBloc
    extends
        BaseBloc<BottomDrawingControllerEvent, BottomDrawingControllerData> {
  BottomDrawingControllerBloc() : super(initState) {
    on<InitBottomDrawingControllerEvent>(_initBottomDrawingControllerEvent);
    on<UpdateDrawingEvent>(_updateDrawingEvent);
    on<UpdateBottomDrawingControllerState>((event, emit) => emit(event.state));
  }

  static BottomDrawingControllerData get initState =>
      (BottomDrawingControllerDataBuilder()
            ..customDrawingController = CustomDrawingController())
          .build();

  void _initBottomDrawingControllerEvent(
    InitBottomDrawingControllerEvent event,
    __,
  ) => add(
    UpdateBottomDrawingControllerState(
      state.rebuild(
        (u) => u..customDrawingController = event.customDrawingController,
      ),
    ),
  );

  void _updateDrawingEvent(UpdateDrawingEvent event, __) {
    switch (event.drawingToolEnum) {
      case DrawingToolEnum.undo:
        add(
          UpdateBottomDrawingControllerState(
            state.rebuild((u) => u.customDrawingController!.undo()),
          ),
        );
      case DrawingToolEnum.redo:
        add(
          UpdateBottomDrawingControllerState(
            state.rebuild((u) => u.customDrawingController!.redo()),
          ),
        );
      case DrawingToolEnum.delete:
        add(
          UpdateBottomDrawingControllerState(
            state.rebuild((u) => u.customDrawingController!.clear()),
          ),
        );
    }
  }
}
