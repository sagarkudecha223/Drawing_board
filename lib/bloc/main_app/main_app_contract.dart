import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';

part 'main_app_contract.g.dart';

abstract class MainAppData implements Built<MainAppData, MainAppDataBuilder> {
  factory MainAppData([void Function(MainAppDataBuilder) updates]) =
      _$MainAppData;

  MainAppData._();

  ScreenState get state;

  String? get errorMessage;

  bool get isLightTheme;

  bool? get isLoggedIn;

  bool get isGuestUser;
}

abstract class MainAppEvent {}

class InitEvent extends MainAppEvent {}

class SetRestApiConfigurationEvent extends MainAppEvent {}

class SetLocalizationEvent extends MainAppEvent {}

class SetProtectedRoutesEvent extends MainAppEvent {}

class DisposeEvent extends MainAppEvent {}

class InActiveEvent extends MainAppEvent {}

class AppResumedEvent extends MainAppEvent {}

class ChangeThemeEvent extends MainAppEvent {}

class UpdateMainAppState extends MainAppEvent {
  final MainAppData state;

  UpdateMainAppState(this.state);
}
