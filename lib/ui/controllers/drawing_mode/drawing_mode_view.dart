import 'package:flutter/material.dart';

import '../../../bloc/drawing_board/drawing_board_bloc.dart';
import '../../../bloc/drawing_board/drawing_board_contract.dart';
import '../../../core/app_extension.dart';
import '../../../core/dimens.dart';
import '../../../core/enum.dart';
import '../../common/animated_list.dart';
import '../../common/common_svg_button.dart';

class DrawingModeView extends StatelessWidget {
  final DrawingBoardBloc bloc;

  const DrawingModeView({super.key, required this.bloc});

  String _getSvg(DrawingMode drawingMode) {
    switch (drawingMode) {
      case DrawingMode.paintMode:
        return bloc.state.paintingTools.icon;
      case DrawingMode.commentMode:
        return DrawingMode.commentMode.image;
      case DrawingMode.selectionMode:
        return DrawingMode.selectionMode.image;
      case DrawingMode.addImageMode:
        return DrawingMode.addImageMode.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: AnimatedInitList(
              direction: Axis.horizontal,
              children:
                  DrawingMode.values
                      .map(
                        (element) => Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimens.spaceMin,
                          ),
                          child: CommonIconButton(
                            isSelected: element == bloc.state.drawingMode,
                            svgIcon: _getSvg(element),
                            onTap:
                                () => bloc.add(
                                  DrawingModeChangeEvent(drawingMode: element),
                                ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
          Flexible(
            child: AnimatedInitList(
              direction: Axis.vertical,
              isVisible: bloc.state.paintingToolsVisible,
              children:
                  PaintTools.values
                      .where((element) => element != bloc.state.paintingTools)
                      .map((element) {
                        return CommonIconButton(
                          isSelected: element == bloc.state.paintingTools,
                          svgIcon: element.icon,
                          onTap:
                              () => bloc.add(
                                PaintingToolsChangeEvent(paintTools: element),
                              ),
                        );
                      })
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
