import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/drawing_board/drawing_board_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static const String drawingBoard = '/drawingBoard';
}

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutes.drawingBoard,
  routes: [
    GoRoute(
      path: AppRoutes.drawingBoard,
      builder: (context, state) => const DrawingBoardScreen(),
    ),
  ],
);
