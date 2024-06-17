import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color primaryColor = Color(0xffBAE162);
  static const Color darkBlue = Color(0xff1E2E3D);
  static const Color darkerBlue = Color(0xff152534);
  static const Color darkerBlue2 = Color(0xff01070c);
  static const Color darkerBlue3 = Color(0xff121217);
  static const Color darkestBlue = Color(0xff0C1C2E);
  static const Color transparent= Color(0xc1c2e);

  static const List<Color> defaultGradient = [
    darkerBlue3,
    darkerBlue2,
  ];

  static const List<Color> transparentGradient = [
    darkBlue,
    transparent,
  ];
}
