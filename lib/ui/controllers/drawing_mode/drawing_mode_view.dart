import 'package:flutter/material.dart';

import '../../../bloc/drawing_board/drawing_board_bloc.dart';
import '../../../core/app_extension.dart';
import '../../../core/colors.dart';
import '../../../core/dimens.dart';
import '../../../core/enum.dart';
import '../../common/animated_list.dart';
import '../../common/common_svg_button.dart';

class DrawingModeView extends StatelessWidget {
  final DrawingBoardBloc bloc;

  const DrawingModeView({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: AnimatedInitList(
        direction: Axis.horizontal,
        children:
            DrawingMode.values
                .map(
                  (element) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.spaceMin),
                    child: CommonIconButton(
                      backgroundColor: AppColors.backgroundColor,
                      svgIcon: element.image,
                      onTap: () {},
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}
