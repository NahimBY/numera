import 'package:flutter/material.dart';

class AppColors {
  //********************/
  // main
  //********************/
  static const Color primary = Color(0xFF1976D2);
  static const Color primaryDark = Color(0xFF0D47A1);
  static const Color secondary = Color(0xFF009688);
  static const Color tertiary = Color(0xFFFFB300);

  //********************/
  // states
  //********************/
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);

  //********************/
  // text
  //********************/
  static const Color textBlack = Color.fromRGBO(0, 0, 0, 1);
  static const Color textWhite = Color.fromRGBO(255, 255, 255, 1);
  static const Color textDarkGray = Color.fromRGBO(85, 85, 85, 1);
  static const Color textGray = Color.fromRGBO(140, 140, 140, 1);
  static const Color textLightGray = Color.fromRGBO(165, 165, 165, 1);

  //********************/
  // fills & backgrounds
  //********************/
  static const Color screenBg = Color.fromRGBO(240, 240, 240, 1);

  static const Color fillBlack = Color.fromRGBO(0, 0, 0, 1);
  static const Color fillWhite = Color.fromRGBO(255, 255, 255, 1);
  static const Color fillLightGray = Color.fromRGBO(165, 165, 165, 1);
  static const Color fillGray = Color.fromRGBO(126, 126, 126, 1);
  static const Color fillDarkGray = Color.fromRGBO(85, 85, 85, 1);
  static const Color fillDarkGrayWithTransparency = Color.fromRGBO(
    241,
    241,
    241,
    0.94,
  );
  static const Color fillPaleGray = Color.fromRGBO(217, 217, 217, 1);
  static const Color fillPaleGrayWithTransparency = Color.fromRGBO(
    249,
    249,
    249,
    0.94,
  );
  static const Color fillLightPaleGray = Color.fromRGBO(230, 230, 230, 1);

  static const List<Color> palette = [
    primary,
    primaryDark,
    secondary,
    tertiary,
    success,
    error,
  ];
}
