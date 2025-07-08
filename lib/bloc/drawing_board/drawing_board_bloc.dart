import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';

import '../../core/colors.dart';
import '../../core/enum.dart';
import '../../ui/controllers/drawing_controller/drawing_controller.dart';
import 'drawing_board_contract.dart';

class DrawingBoardBloc extends BaseBloc<DrawingBoardEvent, DrawingBoardData> {
  DrawingBoardBloc() : super(initState) {
    on<InitDrawingBoardEvent>(_initDrawingBoardEvent);
    on<DrawingModeChangeEvent>(_drawingModeChangeEvent);
    on<PaintingToolsChangeEvent>(_paintingToolsChangeEvent);
    on<SvgChangeEvent>(_svgChangeEvent);
    on<UpdateDrawingBoardState>((event, emit) => emit(event.state));
  }

  static DrawingBoardData get initState =>
      (DrawingBoardDataBuilder()
            ..drawingController = CustomDrawingController()
            ..drawingMode = DrawingMode.paintMode
            ..paintingTools = PaintingTools.freeHand
            ..paintingToolsVisible = true
            ..svgOptionsVisible = false
            ..selectedSvgImage = SvgImageOptions.spiderWeb
            ..selectedColor = AppColors.white)
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
                      : event.drawingMode == DrawingMode.paintMode
              ..svgOptionsVisible =
                  state.svgOptionsVisible == true
                      ? false
                      : event.drawingMode == DrawingMode.addImageMode,
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

  void _svgChangeEvent(SvgChangeEvent event, __) => add(
    UpdateDrawingBoardState(
      state.rebuild(
        (u) =>
            u
              ..selectedSvgImage = event.svgImageOptions
              ..svgOptionsVisible = false,
      ),
    ),
  );
}
