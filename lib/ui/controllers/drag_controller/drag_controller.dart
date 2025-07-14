import 'package:flutter/material.dart';

import '../../../bloc/drawing_board/drawing_board_bloc.dart';
import '../../../core/colors.dart';
import '../../../core/constants.dart';
import '../../painter/drawing_painter.dart';

class DragControllerView extends StatelessWidget {
  final DrawingBoardBloc bloc;

  const DragControllerView({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart:
          (details) =>
              bloc.state.drawingController.startDragging(details.localPosition),
      onPanUpdate: (details) {
        if (bloc.state.drawingController.draggingAction != null) {
          bloc.state.drawingController.updateDragging(details.localPosition);
          bloc.state.drawingController.isDeleteButtonOverlap(
            details.globalPosition,
          );
        }
      },
      onPanEnd: (details) {
        if (bloc.state.drawingController.isHoveringOverDeleteIcon.value) {
          bloc.state.drawingController.deleteDraggingShape();
        } else {
          bloc.state.drawingController.endDragging();
        }
        bloc.state.drawingController.isHoveringOverDeleteIcon.value = false;
      },
      child: CustomPaint(
        painter: DrawingPainter(bloc.state.drawingController),
        size: Size.infinite,
      ),
    );
  }
}

class DragItemDeleteButton extends StatelessWidget {
  final DrawingBoardBloc bloc;

  const DragItemDeleteButton({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 15,
      right: 15,
      child: ValueListenableBuilder<bool>(
        valueListenable: bloc.state.drawingController.isHoveringOverDeleteIcon,
        builder:
            (context, isHovering, child) => AnimatedContainer(
              key: deleteButtonKey,
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(10),
              height: isHovering ? 70 : 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    isHovering ? AppColors.lightRed : AppColors.backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    offset: Offset(0, 1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Icon(
                Icons.delete,
                size: isHovering ? 40 : 30,
                color: isHovering ? AppColors.white : Colors.redAccent.shade200,
              ),
            ),
      ),
    );
  }
}
