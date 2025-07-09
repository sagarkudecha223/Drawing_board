import 'package:flutter/material.dart';
import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';

import '../../core/colors.dart';
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
            ..commentController = TextEditingController()
            ..listOfComments = []
            ..commentPosition = null
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
                      : event.drawingMode == DrawingMode.addImageMode
              ..commentController?.clear()
              ..commentPosition = null,
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
