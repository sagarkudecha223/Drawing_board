import 'package:flutter/material.dart';
import '../../../bloc/drawing_board/drawing_board_bloc.dart';
import '../../../bloc/drawing_board/drawing_board_contract.dart';
import '../../../core/colors.dart';
import '../../../core/dimens.dart';
import '../../common/animation_controller.dart';
import '../../common/container_decoration.dart';
import 'alpha_picker.dart';
import 'color_list.dart';

class ColorPickerDialog extends StatelessWidget {
  final DrawingBoardBloc bloc;

  const ColorPickerDialog({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return AnimateControllers(
      isChange: bloc.state.isCustomColorDialogShow,
      offset: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero),
      child: GestureDetector(
        onVerticalDragEnd: (details) => bloc.add(CustomColorDialogShowEvent()),
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          decoration: ContainerDecoration(
            backgroundColor: AppColors.darkSurface,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _ColorPalette(
                onTap: (color) => bloc.add(ColorChangeEvent(color: color)),
                color: bloc.state.selectedColor,
              ),
              _AlphaPicker(
                value: bloc.state.alpha,
                color: bloc.state.selectedColor,
                onChanged: (value) => bloc.add(AlphaChangeEvent(value: value)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorPalette extends StatelessWidget {
  final Function(Color color) onTap;
  final Color color;

  const _ColorPalette({required this.onTap, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ContainerDecoration(
        radius: Dimens.radius2xSmall,
        borderWidth: 0.5,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(Dimens.radius2xSmall)),
        child: Wrap(
          children:
              customColorS.map((colors) {
                return Column(
                  children:
                      colors
                          .map(
                            (shade) => GestureDetector(
                              onTap: () => onTap(shade),
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: ContainerDecoration(
                                  backgroundColor: shade,
                                  radius: color == shade ? 3 : 0,
                                  borderWidth: 1,
                                  borderColor:
                                      color == shade ? AppColors.white : shade,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                );
              }).toList(),
        ),
      ),
    );
  }
}

class _AlphaPicker extends StatelessWidget {
  final Function(int value) onChanged;
  final int value;
  final Color color;

  const _AlphaPicker({
    required this.onChanged,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: AlphaPicker(
        alpha: value,
        color: color,
        onChanged: (value) => onChanged(value),
      ),
    );
  }
}
