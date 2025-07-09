import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';

import '../../../bloc/drawing_board/drawing_board_bloc.dart';
import '../../../bloc/drawing_board/drawing_board_contract.dart';
import '../../../core/app_extension.dart';
import '../../../core/dimens.dart';
import '../../../core/enum.dart';
import '../../common/animated_container_button.dart';
import '../../common/animated_list.dart';
import '../../common/common_svg_button.dart';

class DrawingModeView extends StatefulWidget {
  final DrawingBoardBloc bloc;

  const DrawingModeView({super.key, required this.bloc});

  @override
  State<DrawingModeView> createState() => _DrawingModeViewState();
}

class _DrawingModeViewState extends State<DrawingModeView> {
  final Map<DrawingMode, LayerLink> _links = {};
  OverlayEntry? _overlayEntry;
  DrawingMode? _expandedMode;

  void _togglePopup(DrawingMode mode) {
    if (_expandedMode == mode) {
      if (_overlayEntry != null) {
        widget.bloc.add(
          mode == DrawingMode.addImageMode
              ? SvgChangeEvent(
                svgImageOptions: widget.bloc.state.selectedSvgImage,
              )
              : PaintingToolsChangeEvent(
                paintTools: widget.bloc.state.paintingTools,
              ),
        );
        Future.delayed(Duration(milliseconds: 200)).then((value) {
          _overlayEntry?.remove();
          _overlayEntry = null;
        });
      } else {
        _showOverlay(mode);
      }
    } else {
      _showOverlay(mode);
    }
  }

  void _showOverlay(DrawingMode mode) async {
    if (_overlayEntry != null) {
      await Future.delayed(Duration(milliseconds: 200)).then((value) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      });
    }

    final link = _links[mode];
    if (link == null) return;

    _overlayEntry = OverlayEntry(
      builder:
          (context) => Stack(
            children: [
              CompositedTransformFollower(
                link: link,
                showWhenUnlinked: false,
                targetAnchor: Alignment.bottomCenter,
                followerAnchor: Alignment.topCenter,
                offset: Offset(
                  0,
                  kIsWeb ? Dimens.space3xSmall : -Dimens.iconSmall,
                ),
                child: BlocBuilder<DrawingBoardBloc, DrawingBoardData>(
                  bloc: widget.bloc,
                  builder: (context, state) {
                    if (mode == DrawingMode.addImageMode) {
                      return _SvgImageOptionsView(
                        bloc: widget.bloc,
                        onReverseComplete: () {
                          _overlayEntry?.remove();
                          _overlayEntry = null;
                          setState(() => _expandedMode = null);
                        },
                      );
                    } else {
                      return _PaintingToolsOptionsView(
                        bloc: widget.bloc,
                        onReverseComplete: () {
                          _overlayEntry?.remove();
                          _overlayEntry = null;
                          setState(() => _expandedMode = null);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _expandedMode = mode);
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      Future.delayed(const Duration(microseconds: 200), () {
        _overlayEntry?.remove();
        _overlayEntry = null;
        if (!mounted) return;
        setState(() => _expandedMode = null);
      });
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  String _getSvg(DrawingMode drawingMode) {
    switch (drawingMode) {
      case DrawingMode.paintMode:
        return widget.bloc.state.paintingTools.icon;
      case DrawingMode.commentMode:
        return DrawingMode.commentMode.image;
      case DrawingMode.selectionMode:
        return DrawingMode.selectionMode.image;
      case DrawingMode.addImageMode:
        return widget.bloc.state.selectedSvgImage.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: AnimatedInitList(
        direction: Axis.horizontal,
        children:
            DrawingMode.values.map((element) {
              final link = _links.putIfAbsent(element, () => LayerLink());
              return CompositedTransformTarget(
                link: link,
                child: Container(
                  padding: const EdgeInsets.all(Dimens.space3xSmall),
                  height: 55,
                  child: Tooltip(
                    message: element.toolTip,
                    child: AnimatedContainerButton(
                      isSelected: element == widget.bloc.state.drawingMode,
                      svgIcon: _getSvg(element),
                      onTap: () {
                        widget.bloc.add(
                          DrawingModeChangeEvent(drawingMode: element),
                        );
                        if (element == DrawingMode.addImageMode ||
                            element == DrawingMode.paintMode) {
                          _togglePopup(element);
                        }
                      },
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}

class _SvgImageOptionsView extends StatelessWidget {
  final DrawingBoardBloc bloc;
  final VoidCallback onReverseComplete;

  const _SvgImageOptionsView({
    required this.bloc,
    required this.onReverseComplete,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedInitList(
      direction: Axis.vertical,
      isVisible: bloc.state.svgOptionsVisible,
      onReverseComplete: () => onReverseComplete,
      children:
          SvgImageOptions.values
              .where((element) => element != bloc.state.selectedSvgImage)
              .map((element) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.spaceMin,
                    vertical: kIsWeb ? 2 : 0,
                  ),
                  child: CommonIconButton(
                    isSelected: element == bloc.state.selectedSvgImage,
                    svgIcon: element.image,
                    onTap:
                        () =>
                            bloc.add(SvgChangeEvent(svgImageOptions: element)),
                  ),
                );
              })
              .toList(),
    );
  }
}

class _PaintingToolsOptionsView extends StatelessWidget {
  final DrawingBoardBloc bloc;
  final VoidCallback onReverseComplete;

  const _PaintingToolsOptionsView({
    required this.bloc,
    required this.onReverseComplete,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedInitList(
      direction: Axis.vertical,
      isVisible: bloc.state.paintingToolsVisible,
      onReverseComplete: () => onReverseComplete,
      children:
          PaintingTools.values
              .where((element) => element != bloc.state.paintingTools)
              .map(
                (element) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.spaceMin,
                    vertical: kIsWeb ? 2 : 0,
                  ),
                  child: CommonIconButton(
                    isSelected: element == bloc.state.paintingTools,
                    svgIcon: element.icon,
                    onTap:
                        () => bloc.add(
                          PaintingToolsChangeEvent(paintTools: element),
                        ),
                  ),
                ),
              )
              .toList(),
    );
  }
}
