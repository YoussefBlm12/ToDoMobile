import 'package:flutter/material.dart';

class AppUI {
  static double kMobileBreakpoint = 576;
  static double kTabletBreakpoint = 1050;
  static double kDesktopBreakPoint = 1366;

  // SizedBox
  static double defaultSizedBoxTiny = 16;
  static double defaultSizedBoxMedium = 30;
  static double defaultSizedBoxBig = 45;

  // Padding
  static double defaultTinyPadding = 12;
  static double defaultPadding = 16;
  static double defaultBigPadding = 20;
  // Blur
  static double defaultBlurRadius = 4.0;
  static double defaultSpreadRadius = 1.0;
  // Button
  static double defaultAppButtonElevation = 4.0;
  static double defaultAppButtonRadius = 8.0;
  static ShapeBorder? defaultAppButtonShapeBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(defaultAppButtonRadius)));
}
