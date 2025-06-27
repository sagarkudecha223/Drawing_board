// ignore_for_file: constant_identifier_names
import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/injector_imports.dart';
import '../base_arch_config/base_arch_config.dart';
import '../bloc/main_app/main_app_bloc.dart';
import '../core/cache/preference_store.dart';
import '../services/theme_service/app_theme.dart';
import '../services/theme_service/theme_service.dart';

part 'injector.g.dart';

abstract class Injector extends BaseInjector {
  static late KiwiContainer container;

  static Future<bool> setup() async {
    container = BaseInjector.baseContainer;

    _$Injector()._configure();
    await container.resolve<PreferenceStore>().init();
    container.resolve<BaseArchConfig>().init();
    return true;
  }

  void _configure() {
    // Configure modules here
    _registerMiscModules();
    _registerCache();
    _registerApis();
    _registerServices();
    _registerBlocProviders();
  }

  /// Register Data Stores
  @Register.singleton(PreferenceStore)
  void _registerCache();

  @Register.singleton(AppTheme)
  void _registerMiscModules();

  /// Register Apis
  void _registerApis();

  /// Register Services
  @Register.singleton(ThemeService)
  @Register.singleton(BaseArchConfig)
  void _registerServices();

  /// Register Bloc dependencies
  @Register.factory(MainAppBloc)
  void _registerBlocProviders();
}
