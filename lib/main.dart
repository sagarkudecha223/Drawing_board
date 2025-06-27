import 'dart:async';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/injector_imports.dart';
import 'package:sizer/sizer.dart';
import 'inject/injector.dart';
import 'main_app.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await BaseInjector.setup();
      await Injector.setup();

      runApp(
        Sizer(
          builder: (context, orientation, deviceType) => const EntryPoint(),
        ),
      );
    },
    (Object error, StackTrace stackTrace) {
      ///Print log issues in console while app is in development
      if (error == 'No Internet Connection') {
        return;
      }
      printLog(message: 'Error: $error \n StackTrace: $stackTrace');
      if (!kDebugMode) {
        ///Report issues to firebase when not in development
      }
    },
  );
}
