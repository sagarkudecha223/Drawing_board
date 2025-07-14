import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
  OverlayEntry? _activeOverlay;
  GlobalKey<_PopupListState>? _overlayKey;
  Completer<void>? _dismissCompleter;

  void _togglePopup(DrawingMode mode) {
    widget.bloc.add(DrawingModeChangeEvent(drawingMode: mode));
    if (widget.bloc.state.drawingMode == mode) {
      if (_activeOverlay == null) {
        _showPopup(mode);
      } else {
        _removePopup();
      }
    } else {
      _removePopup().then((_) {
        Future.delayed(
          const Duration(milliseconds: 50),
          () => _showPopup(mode),
        );
      });
    }
  }

  Future<void> _removePopup() async {
    final popupKey = _overlayKey;
    _overlayKey = null;

    if (popupKey?.currentState != null) {
      _dismissCompleter = Completer<void>();
      await popupKey!.currentState!.dismissWithAnimation();
      await _dismissCompleter!.future;
    }

    setState(() {});
    _activeOverlay?.remove();
    _activeOverlay = null;
  }

  void _showPopup(DrawingMode mode) {
    if (mode == DrawingMode.commentMode ||
        mode == DrawingMode.selectionMode ||
        mode == DrawingMode.colorPalette) {
      return;
    }
    final link = _links.putIfAbsent(mode, () => LayerLink());
    final key = GlobalKey<_PopupListState>();

    final entry = OverlayEntry(
      builder:
          (context) => Positioned.fill(
            child: Stack(
              children: [
                CompositedTransformFollower(
                  link: link,
                  targetAnchor: Alignment.bottomCenter,
                  followerAnchor: Alignment.topCenter,
                  offset: Offset(
                    0,
                    kIsWeb ? Dimens.space3xSmall : -Dimens.iconSmall,
                  ),
                  showWhenUnlinked: false,
                  child: _PopupList(
                    key: key,
                    onClose: () => _dismissCompleter?.complete(),
                    children:
                        mode == DrawingMode.paintMode
                            ? PaintingTools.values
                                .where(
                                  (element) =>
                                      element !=
                                      widget.bloc.state.paintingTools,
                                )
                                .map(
                                  (element) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: Dimens.spaceMin,
                                      vertical: kIsWeb ? 2 : 0,
                                    ),
                                    child: CommonIconButton(
                                      svgIcon: element.icon,
                                      onTap: () {
                                        widget.bloc.add(
                                          PaintingToolsChangeEvent(
                                            paintTools: element,
                                          ),
                                        );
                                        _removePopup();
                                      },
                                    ),
                                  ),
                                )
                                .toList()
                            : SvgImageOptions.values
                                .where(
                                  (element) =>
                                      element !=
                                      widget.bloc.state.selectedSvgImage,
                                )
                                .map(
                                  (element) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: Dimens.spaceMin,
                                      vertical: kIsWeb ? 2 : 0,
                                    ),
                                    child: CommonIconButton(
                                      svgIcon: element.image,
                                      onTap: () {
                                        widget.bloc.add(
                                          SvgChangeEvent(
                                            svgImageOptions: element,
                                          ),
                                        );
                                        _removePopup();
                                      },
                                    ),
                                  ),
                                )
                                .toList(),
                  ),
                ),
              ],
            ),
          ),
    );

    Overlay.of(context).insert(entry);
    _activeOverlay = entry;
    _overlayKey = key;
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
      case DrawingMode.colorPalette:
        return DrawingMode.colorPalette.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedInitList(
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
                    onTap: () => _togglePopup(element),
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}

class _PopupList extends StatefulWidget {
  final List<Widget> children;
  final VoidCallback onClose;

  const _PopupList({super.key, required this.children, required this.onClose});

  @override
  State<_PopupList> createState() => _PopupListState();
}

class _PopupListState extends State<_PopupList> {
  bool isVisible = true;
  bool _isDismissing = false;
  Completer<void>? _localCompleter;

  Future<void> dismissWithAnimation() {
    if (_isDismissing) return _localCompleter?.future ?? Future.value();

    _isDismissing = true;
    _localCompleter = Completer<void>();

    setState(() => isVisible = false);

    return _localCompleter!.future;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedInitList(
        isVisible: isVisible,
        direction: Axis.vertical,
        onReverseComplete: () {
          widget.onClose();
          _localCompleter?.complete();
        },
        children: widget.children,
      ),
    );
  }
}
