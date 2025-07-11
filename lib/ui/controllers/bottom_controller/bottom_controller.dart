import 'package:flutter/material.dart';
import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';
import '../../../bloc/bottom_drawing_controller/bottom_drawing_controller_bloc.dart';
import '../../../bloc/bottom_drawing_controller/bottom_drawing_controller_contract.dart';
import '../../../bloc/drawing_board/drawing_board_bloc.dart';
import '../../../core/app_extension.dart';
import '../../../core/colors.dart';
import '../../../core/dimens.dart';
import '../../../core/enum.dart';
import '../../common/animation_controller.dart';
import '../../common/svg_icon.dart';
import '../drawing_controller/drawing_controller.dart';

class BottomViewControllerView extends StatelessWidget {
  final DrawingBoardBloc bloc;

  const BottomViewControllerView({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return AnimateControllers(
      offset: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero),
      isChange:
          (bloc.state.drawingMode == DrawingMode.paintMode ||
              bloc.state.drawingMode == DrawingMode.addImageMode ||
              bloc.state.drawingMode == DrawingMode.colorPalette),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: BottomDrawingControllerView(
            customDrawingController: bloc.state.drawingController,
          ),
        ),
      ),
    );
  }
}

class BottomDrawingControllerView extends StatefulWidget {
  final CustomDrawingController customDrawingController;

  const BottomDrawingControllerView({
    super.key,
    required this.customDrawingController,
  });

  @override
  State<BottomDrawingControllerView> createState() =>
      _BottomDrawingControllerViewState();
}

class _BottomDrawingControllerViewState
    extends
        BaseState<BottomDrawingControllerBloc, BottomDrawingControllerView> {
  @override
  void initState() {
    super.initState();
    bloc.add(
      InitBottomDrawingControllerEvent(
        customDrawingController: widget.customDrawingController,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomDrawingControllerBloc>(
      create: (BuildContext context) => bloc,
      child:
          BlocBuilder<BottomDrawingControllerBloc, BottomDrawingControllerData>(
            builder:
                (BuildContext context, _) => _BottomDrawingContent(bloc: bloc),
          ),
    );
  }
}

class _BottomDrawingContent extends StatelessWidget {
  final BottomDrawingControllerBloc bloc;

  const _BottomDrawingContent({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      spacing: Dimens.paddingSmall,
      children:
          DrawingToolEnum.values
              .map(
                (element) =>
                    _BottomDrawingItem(drawingToolEnum: element, bloc: bloc),
              )
              .toList(),
    );
  }
}

class _BottomDrawingItem extends StatelessWidget {
  final DrawingToolEnum drawingToolEnum;
  final BottomDrawingControllerBloc bloc;

  const _BottomDrawingItem({required this.drawingToolEnum, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(Dimens.radiusMedium),
      onTap:
          () => bloc.add(UpdateDrawingEvent(drawingToolEnum: drawingToolEnum)),
      child: Tooltip(
        message: drawingToolEnum.tooltip,
        child: Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(Dimens.radiusMedium),
            ),
            color: AppColors.transparent,
            border: Border.all(color: AppColors.transparent),
            boxShadow: [
              BoxShadow(
                blurStyle: BlurStyle.outer,
                color: AppColors.shadowColor,
                blurRadius: 5,
              ),
            ],
          ),
          child: AppSvgIcon(
            drawingToolEnum.icon,
            height: 22,
            color: AppColors.iconColor,
          ),
        ),
      ),
    );
  }
}
