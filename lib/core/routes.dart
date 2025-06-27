import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/home/home_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static const String homeScreen = '/homeScreen';
}

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutes.homeScreen,
  routes: [
    GoRoute(
      path: AppRoutes.homeScreen,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
