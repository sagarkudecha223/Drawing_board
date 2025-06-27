import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/localization_imports.dart';

abstract class AppLocalization extends BaseLocalization {
  AppLocalization({required super.code, required super.name, super.country});

  static AppLocalization currentLocalization() =>
      Localization.currentLocalization as AppLocalization;

  String get retry;

  String get ok;
}
