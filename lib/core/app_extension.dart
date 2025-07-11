import 'package:flutter/material.dart';
import 'colors.dart';
import 'enum.dart';
import 'images.dart';

extension AppLoaderThemeColor on AppLoaderTheme {
  Color get backgroundColor {
    switch (this) {
      case AppLoaderTheme.light:
        return AppColors.primaryBlue1;
      case AppLoaderTheme.dark:
        return AppColors.secondary;
    }
  }

  Color get valueColor {
    switch (this) {
      case AppLoaderTheme.light:
        return AppColors.lightBackground;
      case AppLoaderTheme.dark:
        return AppColors.darkBackground;
    }
  }
}

extension SharedPreferenceStoreExtractor on SharedPreferenceStore {
  String get preferenceKey => name;

  Type get getRuntimeType {
    switch (this) {
      case SharedPreferenceStore.IS_LIGHT_THEME_MODE:
        return bool;
    }
  }
}

extension DrawingModeExtension on DrawingMode {
  String get toolTip {
    switch (this) {
      case DrawingMode.paintMode:
        return 'Paint Mode';
      case DrawingMode.commentMode:
        return 'Comment Mode';
      case DrawingMode.addImageMode:
        return 'Image Mode';
      case DrawingMode.selectionMode:
        return 'Drag Mode';
      case DrawingMode.colorPalette:
        return 'Color palette';
    }
  }

  String get image {
    switch (this) {
      case DrawingMode.paintMode:
        return Images.pencil;
      case DrawingMode.commentMode:
        return Images.comment;
      case DrawingMode.addImageMode:
        return Images.imagesIcon;
      case DrawingMode.selectionMode:
        return Images.selection;
      case DrawingMode.colorPalette:
        return Images.colorPalette;
    }
  }

  MouseCursor getCursorForMode(DrawingMode mode) {
    switch (mode) {
      case DrawingMode.paintMode:
        return SystemMouseCursors.precise;
      case DrawingMode.commentMode:
        return SystemMouseCursors.text;
      case DrawingMode.selectionMode:
        return SystemMouseCursors.grabbing;
      case DrawingMode.addImageMode:
        return SystemMouseCursors.move;
      case DrawingMode.colorPalette:
        return SystemMouseCursors.click;
    }
  }
}

extension PaintingToolsExtension on PaintingTools {
  String get icon {
    switch (this) {
      case PaintingTools.freeHand:
        return Images.pencil;
      case PaintingTools.rectangle:
        return Images.rectangle;
      case PaintingTools.circle:
        return Images.circle;
      case PaintingTools.arrow:
        return Images.arrowUp;
    }
  }

  String get tooltip {
    switch (this) {
      case PaintingTools.freeHand:
        return 'Free Hand';
      case PaintingTools.rectangle:
        return 'Rectangle';
      case PaintingTools.circle:
        return 'Circle';
      case PaintingTools.arrow:
        return 'Arrow';
    }
  }
}

extension SvgImageOptionsExtension on SvgImageOptions {
  String get image {
    switch (this) {
      case SvgImageOptions.spiderWeb:
        return Images.spiderWeb;
      case SvgImageOptions.star:
        return Images.star;
      case SvgImageOptions.cross:
        return Images.cross;
    }
  }

  String get toolTip {
    switch (this) {
      case SvgImageOptions.spiderWeb:
        return 'Spider Web';
      case SvgImageOptions.star:
        return 'Star';
      case SvgImageOptions.cross:
        return 'Cross';
    }
  }
}

extension DrawingToolExtension on DrawingToolEnum {
  String get icon {
    switch (this) {
      case DrawingToolEnum.undo:
        return Images.undo;
      case DrawingToolEnum.redo:
        return Images.redo;
      case DrawingToolEnum.delete:
        return Images.delete;
    }
  }

  String get tooltip {
    switch (this) {
      case DrawingToolEnum.undo:
        return 'Undo';
      case DrawingToolEnum.redo:
        return 'Redo';
      case DrawingToolEnum.delete:
        return 'Delete';
    }
  }
}
