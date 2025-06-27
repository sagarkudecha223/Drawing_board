import 'package:flutter_base_architecture_plugin/base_arch_controller/base_arch_controller.dart';
import '../core/constants.dart';

class BaseArchConfig {
  final BaseArchController _baseArchController;

  BaseArchConfig(this._baseArchController);

  void init() {
    _setLocalization();
  }

  void _setLocalization() => _baseArchController.setLocalization(
    localizationList: AppConstants.localizationList,
  );
}
