import 'package:flutter/material.dart';

class KColors {
  final Color primary;
  final Color whiteColor;
  final Color background;
  final Color gradientColor1;
  final Color gradientColor2;
  final Color registerTextColor;

  const KColors({
    required this.primary,
    required this.whiteColor,
    required this.background,
    required this.gradientColor1,
    required this.gradientColor2,
    required this.registerTextColor,
  });
}

KColors colorScheme1 = const KColors(
    primary: Color.fromRGBO(26, 28, 26, 1),
    whiteColor: Color.fromRGBO(255, 255, 255, 1),
    background: Color.fromRGBO(245, 245, 245, 1),
    gradientColor1: Color.fromRGBO(26, 28, 26, 1),
    gradientColor2: Color.fromARGB(255, 88, 93, 88),
    registerTextColor: Color.fromARGB(255, 102, 106, 102));
