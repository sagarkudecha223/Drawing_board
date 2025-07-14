// ignore_for_file: constant_identifier_names, type_annotate_public_apis

import 'package:flutter/material.dart';

import '../../localization/en.dart';

var navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey deleteButtonKey = GlobalKey();

class AppConstants {
  static final localizationList = [EnglishLocalization()];
}
