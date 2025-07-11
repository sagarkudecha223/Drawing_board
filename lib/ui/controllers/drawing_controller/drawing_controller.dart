import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/enum.dart';
import 'draw_action_model.dart';

class CustomDrawingController extends ValueNotifier<List<DrawActionModel>> {
  CustomDrawingController() : super([]);

  final List<DrawActionModel> _redoStack = [];
  DrawActionModel? _currentAction;

  DrawActionModel? draggingAction;
  Offset? _dragStart;
  final ValueNotifier<bool> isHoveringOverDeleteIcon = ValueNotifier<bool>(
    false,
  );

  void startDrawing(
    Offset point,
    Color color,
    double strokeWidth,
    PaintingTools tools,
    String? image,
    bool isImageMode,
  ) {
    _currentAction = DrawActionModel(
      points: [point],
      color: color,
      strokeWidth: strokeWidth,
      shape: tools,
      svgAsset: isImageMode ? image : null,
    );
    value = [...value, _currentAction!];
  }

  void updateDrawing(Offset point) {
    if (_currentAction != null) {
      if (_currentAction!.svgAsset != null) {
        if (_currentAction!.points.length == 1) {
          _currentAction!.points.add(point);
        } else {
          _currentAction!.points[1] = point;
        }
      } else {
        if (_currentAction!.shape == PaintingTools.freeHand) {
          _currentAction!.points.add(point);
        } else if (_currentAction!.points.length == 1) {
          _currentAction!.points.add(point);
        } else {
          _currentAction!.points[1] = point;
        }
      }
      notifyListeners();
    }
  }

  void endDrawing() {
    _currentAction = null;
  }

  void undo() {
    if (value.isNotEmpty) {
      _redoStack.add(value.removeLast());
      notifyListeners();
    }
  }

  void redo() {
    if (_redoStack.isNotEmpty) {
      value = [...value, _redoStack.removeLast()];
      notifyListeners();
    }
  }

  void clear() {
    value = [];
    _redoStack.clear();
    notifyListeners();
  }

  void startDragging(Offset point) {
    // Check if the point is inside any shape's bounding box
    for (var action in value) {
      if (_isPointInsideAction(action, point)) {
        draggingAction = action;
        _dragStart = point;
        break;
      }
    }
  }

  // Dragging: Update the position of the dragged shape
  void updateDragging(Offset point) {
    if (draggingAction != null && _dragStart != null) {
      Offset dragDelta = point - _dragStart!;
      for (int i = 0; i < draggingAction!.points.length; i++) {
        draggingAction!.points[i] += dragDelta;
      }
      _dragStart = point;
      notifyListeners();
    }
  }

  // Dragging: End dragging
  void endDragging() {
    draggingAction = null;
    _dragStart = null;
  }

  void deleteDraggingShape() {
    if (draggingAction != null) {
      value = value.where((action) => action != draggingAction).toList();
      draggingAction = null;
      notifyListeners();
    }
  }

  bool _isPointInsideAction(DrawActionModel action, Offset point) {
    if (action.points.length >= 2) {
      Rect boundingBox = Rect.fromPoints(action.points[0], action.points[1]);
      return boundingBox.contains(point);
    }
    return false;
  }

  bool isOverDeleteIcon(
    Offset currentPosition,
    Size canvasSize,
    Rect deleteIconRect,
  ) {
    return deleteIconRect.contains(currentPosition);
  }

  Rect getDeleteIconRect(Size size) {
    const double iconSize = 50;
    const double bottomPadding = 25;
    const double rightPadding = 25;
    return Rect.fromLTWH(
      size.width - iconSize - rightPadding, // Right side
      size.height - iconSize - bottomPadding, // Bottom side
      iconSize,
      iconSize,
    );
  }

  bool isDeleteButtonOverlap(Offset draggedPosition) {
    RenderBox targetBox =
        deleteButtonKey.currentContext!.findRenderObject() as RenderBox;
    Offset targetPosition = targetBox.localToGlobal(Offset.zero);
    Size targetSize = targetBox.size;

    bool overlaps =
        draggedPosition.dx >= targetPosition.dx &&
        draggedPosition.dx <= targetPosition.dx + targetSize.width &&
        draggedPosition.dy >= targetPosition.dy &&
        draggedPosition.dy <= targetPosition.dy + targetSize.height;

    if (overlaps) {
      isHoveringOverDeleteIcon.value = true;
    } else {
      isHoveringOverDeleteIcon.value = false;
    }

    return overlaps;
  }
}
