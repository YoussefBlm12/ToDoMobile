import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';


class Themes {
  static final light = ThemeData(
    primaryColor: ColorManager.primary,
    backgroundColor: ColorManager.white,
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    primaryColor: ColorManager.darkGreyClr,
    backgroundColor: ColorManager.darkGreyClr,
    brightness: Brightness.dark,
  );
}