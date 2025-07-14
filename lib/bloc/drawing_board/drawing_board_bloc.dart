import 'package:flutter/material.dart';
import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';

import '../../core/enum.dart';
import '../../ui/controllers/comment_mode/comment_model.dart';
import '../../ui/controllers/drawing_controller/drawing_controller.dart';
import 'drawing_board_contract.dart';

class DrawingBoardBloc extends BaseBloc<DrawingBoardEvent, DrawingBoardData> {
  DrawingBoardBloc() : super(initState) {
    on<InitDrawingBoardEvent>(_initDrawingBoardEvent);
    on<DrawingModeChangeEvent>(_drawingModeChangeEvent);
    on<PaintingToolsChangeEvent>(_paintingToolsChangeEvent);
    on<SvgChangeEvent>(_svgChangeEvent);
    on<ShowAddCommentEvent>(_showAddCommentEvent);
    on<AddCommentEvent>(_addCommentEvent);
    on<OutSideTapEvent>(_outSideTapEvent);
    on<DeleteCommentEvent>(_deleteCommentEvent);
    on<CustomColorDialogShowEvent>(_customColorDialogShowEvent);
    on<ColorChangeEvent>(_colorChangeEvent);
    on<AlphaChangeEvent>(_alphaChangeEvent);
    on<UpdateDrawingBoardState>((event, emit) => emit(event.state));
  }

  static DrawingBoardData get initState =>
      (DrawingBoardDataBuilder()
            ..drawingController = CustomDrawingController()
            ..drawingMode = DrawingMode.paintMode
            ..paintingTools = PaintingTools.freeHand
            ..selectedSvgImage = SvgImageOptions.spiderWeb
            ..commentController = TextEditingController()
            ..listOfComments = []
            ..commentPosition = null
            ..isCustomColorDialogShow = false
            ..alpha = 255
            ..selectedColor = const Color(0xFF9E9E9E))
          .build();

  void _initDrawingBoardEvent(_, __) {}

  void _drawingModeChangeEvent(DrawingModeChangeEvent event, __) => add(
    UpdateDrawingBoardState(
      state.rebuild(
        (u) =>
            u
              ..drawingMode = event.drawingMode
              ..isCustomColorDialogShow = false
              ..commentController?.clear()
              ..commentPosition = null
              ..isCustomColorDialogShow =
                  event.drawingMode == DrawingMode.colorPalette
                      ? !state.isCustomColorDialogShow
                      : false,
      ),
    ),
  );

  void _paintingToolsChangeEvent(PaintingToolsChangeEvent event, __) => add(
    UpdateDrawingBoardState(
      state.rebuild((u) => u.paintingTools = event.paintTools),
    ),
  );

  void _svgChangeEvent(SvgChangeEvent event, __) => add(
    UpdateDrawingBoardState(
      state.rebuild((u) => u..selectedSvgImage = event.svgImageOptions),
    ),
  );

  void _customColorDialogShowEvent(_, __) => add(
    UpdateDrawingBoardState(
      state.rebuild(
        (u) => u.isCustomColorDialogShow = !state.isCustomColorDialogShow,
      ),
    ),
  );

  void _colorChangeEvent(ColorChangeEvent event, __) {
    add(
      UpdateDrawingBoardState(
        state.rebuild(
          (u) =>
              u
                ..selectedColor = event.color
                ..alpha = 255,
        ),
      ),
    );
  }

  void _alphaChangeEvent(AlphaChangeEvent event, __) => add(
    UpdateDrawingBoardState(
      state.rebuild(
        (u) =>
            u
              ..alpha = event.value
              ..selectedColor?.withAlpha(event.value),
      ),
    ),
  );

  void _showAddCommentEvent(ShowAddCommentEvent event, _) {
    Offset? offset =
        state.commentPosition == null ? event.tapUpDetails.localPosition : null;

    add(
      UpdateDrawingBoardState(
        state.rebuild(
          (u) =>
              u
                ..commentPosition = Offset(offset!.dx, offset.dy)
                ..commentController?.clear(),
        ),
      ),
    );
  }

  void _addCommentEvent(_, __) {
    final comment = CommentModel(
      position: state.commentPosition!,
      initial: state.commentController.text[0].toUpperCase(),
      globalKey: GlobalKey(),
      comments: [state.commentController.text],
    );
    add(
      UpdateDrawingBoardState(
        state.rebuild(
          (u) =>
              u
                ..listOfComments?.add(comment)
                ..commentController?.clear()
                ..commentPosition = null,
        ),
      ),
    );
  }

  void _outSideTapEvent(_, __) => add(
    UpdateDrawingBoardState(
      state.rebuild(
        (u) =>
            u
              ..commentController?.clear()
              ..commentPosition = null,
      ),
    ),
  );

  void _deleteCommentEvent(DeleteCommentEvent event, _) {
    final existingIndex = state.listOfComments.indexWhere(
      (t) => t == event.commentModel,
    );

    final updateCommentList = [...state.listOfComments];

    updateCommentList.removeAt(existingIndex);

    add(
      UpdateDrawingBoardState(
        state.rebuild(
          (u) =>
              u
                ..listOfComments = updateCommentList
                ..commentController?.clear()
                ..commentPosition = null,
        ),
      ),
    );
  }
}
