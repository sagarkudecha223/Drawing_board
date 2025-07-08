import 'package:flutter/material.dart';
import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';

import '../../bloc/drawing_board/drawing_board_bloc.dart';
import '../../bloc/drawing_board/drawing_board_contract.dart';
import '../../core/app_extension.dart';
import '../../core/dimens.dart';
import '../../core/enum.dart';
import '../controllers/comment_mode/comment_view.dart';
import '../controllers/drag_controller/drag_controller.dart';
import '../controllers/drawing_mode/drawing_mode_view.dart';
import '../controllers/image_controller/image_controller.dart';
import '../painter/drawing_painter.dart';

class DrawingBoardScreen extends StatefulWidget {
  const DrawingBoardScreen({super.key});

  @override
  State<DrawingBoardScreen> createState() => _DrawingBoardScreenState();
}

class _DrawingBoardScreenState
    extends BaseState<DrawingBoardBloc, DrawingBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<DrawingBoardBloc>(
          create: (_) => bloc,
          child: BlocBuilder<DrawingBoardBloc, DrawingBoardData>(
            builder: (_, __) => _MainContent(bloc: bloc),
          ),
        ),
      ),
    );
  }
}

class _MainContent extends StatelessWidget {
  const _MainContent({required this.bloc});

  final DrawingBoardBloc bloc;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:
          (context, constraints) => Stack(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            children: [
              IgnorePointer(
                ignoring: !(bloc.state.drawingMode == DrawingMode.addImageMode),
                child: ImageDrawWidget(
                  controller: bloc.state.drawingController,
                  svgColor: bloc.state.selectedColor,
                ),
              ),
              Positioned.fill(child: _GestureDetector(bloc: bloc)),
              IgnorePointer(
                ignoring: bloc.state.drawingMode != DrawingMode.selectionMode,
                child: DragControllerView(bloc: bloc),
              ),
              CommentView(bloc: bloc),
              Padding(
                padding: const EdgeInsets.all(Dimens.spaceSmall),
                child: DrawingModeView(bloc: bloc),
              ),
              if (bloc.state.drawingMode == DrawingMode.selectionMode)
                DragItemDeleteButton(bloc: bloc),
            ],
          ),
    );
  }
}

class _GestureDetector extends StatelessWidget {
  final DrawingBoardBloc bloc;

  const _GestureDetector({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart:
          (details) => bloc.state.drawingController.startDrawing(
            details.localPosition,
            bloc.state.selectedColor,
            1.0,
            bloc.state.paintingTools,
            bloc.state.selectedSvgImage.image,
            bloc.state.drawingMode == DrawingMode.addImageMode,
          ),
      onPanUpdate:
          (details) =>
              bloc.state.drawingController.updateDrawing(details.localPosition),
      onPanEnd: (details) => bloc.state.drawingController.endDrawing(),
      child: CustomPaint(
        painter: DrawingPainter(bloc.state.drawingController),
        size: Size.infinite,
      ),
    );
  }
}
