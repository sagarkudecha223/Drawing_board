import 'package:flutter/material.dart';
import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';

import 'bloc/main_app/main_app_bloc.dart';
import 'bloc/main_app/main_app_contract.dart';
import 'core/colors.dart';
import 'core/constants.dart';
import 'core/dimens.dart';
import 'core/routes.dart';
import 'services/theme_service/app_theme.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends BaseState<MainAppBloc, EntryPoint>
    with WidgetsBindingObserver {
  Size? deviceSize;

  @override
  void initState() {
    super.initState();
    bloc.add(InitEvent());
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      deviceSize = MediaQuery.of(context).size;
      _updateDeviceType();
    });
  }

  _compareSize() {
    if (deviceSize != null && deviceSize != MediaQuery.of(context).size) {
      _updateDeviceType();
    }
  }

  void _updateDeviceType() {
    final size = MediaQuery.of(context).size.shortestSide;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (size < 450) {
        Dimens.setDeviceType(DeviceType.mobile);
      } else if (size < 850) {
        Dimens.setDeviceType(DeviceType.tablet);
      } else {
        Dimens.setDeviceType(DeviceType.desktop);
      }
      _forceRebuildWidgets();
      deviceSize = MediaQuery.of(context).size;
    });
  }

  @override
  void onViewEvent(ViewAction event) {
    switch (event.runtimeType) {
      case const (ChangeTheme):
        _forceRebuildWidgets();
      case const (NavigateScreen):
        buildHandleActionEvent(event as NavigateScreen);
    }
  }

  void buildHandleActionEvent(NavigateScreen screen) {
    switch (screen.target) {}
  }

  void _forceRebuildWidgets() {
    void rebuild(Element widget) {
      widget.markNeedsBuild();
      widget.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      bloc.add(DisposeEvent());
    } else if (state == AppLifecycleState.inactive) {
      bloc.add(InActiveEvent());
    } else if (state == AppLifecycleState.resumed) {
      bloc.add(AppResumedEvent());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainAppBloc>(
      create: (_) => bloc,
      child: BlocBuilder<MainAppBloc, MainAppData>(
        builder:
            (_, __) => LayoutBuilder(
              builder: (_, __) {
                _compareSize();
                return MaterialApp.router(
                  themeMode:
                      AppColors.isLightTheme ? ThemeMode.light : ThemeMode.dark,
                  darkTheme: AppTheme.darkTheme,
                  routerConfig: router,
                  debugShowCheckedModeBanner: false,
                  supportedLocales:
                      AppConstants.localizationList.toLocaleList(),
                );
              },
            ),
      ),
    );
  }
}
