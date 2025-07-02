import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';

import '../../core/enum.dart';
import '../../ui/controllers/drawing_controller/drawing_controller.dart';
import 'drawing_board_contract.dart';

class DrawingBoardBloc extends BaseBloc<DrawingBoardEvent, DrawingBoardData> {
  DrawingBoardBloc() : super(initState) {
    on<InitDrawingBoardEvent>(_initDrawingBoardEvent);
    on<DrawingModeChangeEvent>(_drawingModeChangeEvent);
    on<PaintingToolsChangeEvent>(_paintingToolsChangeEvent);
    on<UpdateDrawingBoardState>((event, emit) => emit(event.state));
  }

  static DrawingBoardData get initState =>
      (DrawingBoardDataBuilder()
            ..drawingController = CustomDrawingController()
            ..drawingMode = DrawingMode.paintMode
            ..paintingTools = PaintTools.freeHand
            ..paintingToolsVisible = true)
          .build();

  void _initDrawingBoardEvent(_, __) {}

  void _drawingModeChangeEvent(DrawingModeChangeEvent event, __) => add(
    UpdateDrawingBoardState(
      state.rebuild(
        (u) =>
            u
              ..drawingMode = event.drawingMode
              ..paintingToolsVisible =
                  state.paintingToolsVisible == true
                      ? false
                      : event.drawingMode == DrawingMode.paintMode,
      ),
    ),
  );

  void _paintingToolsChangeEvent(PaintingToolsChangeEvent event, __) => add(
    UpdateDrawingBoardState(
      state.rebuild(
        (u) =>
            u
              ..paintingTools = event.paintTools
              ..paintingToolsVisible = false,
      ),
    ),
  );
}
