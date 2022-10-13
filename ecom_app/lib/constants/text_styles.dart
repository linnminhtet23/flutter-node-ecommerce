import 'package:ecom_app/constants/activate_constant.dart';
import 'package:flutter/material.dart';

class KTextStyles {
  final TextStyle gradientBtnText;
  final TextStyle registerText;

  const KTextStyles({
    required this.gradientBtnText,
    required this.registerText,
  });
}

KTextStyles textStyles1 =  KTextStyles(
  gradientBtnText: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  ),
  registerText: TextStyle(
    fontWeight: FontWeight.w500,
    color: activeColors.registerTextColor,
  ),
);
