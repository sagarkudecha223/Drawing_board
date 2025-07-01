import 'package:flutter/material.dart';
import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';

import '../../bloc/drawing_board/drawing_board_bloc.dart';
import '../../bloc/drawing_board/drawing_board_contract.dart';
import '../../core/dimens.dart';
import '../../core/enum.dart';
import '../controllers/drawing_mode/drawing_mode_view.dart';
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
    return Stack(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      children: [
        Positioned.fill(child: _GestureDetector(bloc: bloc)),
        Padding(
          padding: EdgeInsets.all(Dimens.spaceSmall),
          child: DrawingModeView(bloc: bloc),
        ),
      ],
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
            details.globalPosition,
            Colors.white,
            1.0,
            PaintTools.freeHand,
            '',
            // bloc.state.selectedColor.withAlpha(bloc.state.alpha),
            // bloc.state.strokeWidth,
            // bloc.state.selectedPaintingTools,
            // bloc.state.selectedSvg,
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
