import 'package:flutter/material.dart';
import 'package:numera/config/theme/colors_theme.dart';
import 'package:numera/config/theme/fonts_theme.dart';

export 'package:numera/config/theme/colors_theme.dart';
export 'package:numera/config/theme/fonts_theme.dart';

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0}) : assert(selectedColor >= 0 && selectedColor < AppColors.palette.length, 'Colors must be between 0 and ${AppColors.palette.length - 1}');

  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: AppColors.palette[selectedColor],
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.screenBg,
      textTheme: AppFonts.textTheme,
      appBarTheme: AppBarTheme(
        titleTextStyle: AppFonts.appBarTitle,
        iconTheme: const IconThemeData(color: AppColors.fillBlack, size: 26),
        elevation: 0,
      ),
      iconTheme: const IconThemeData(color: AppColors.fillBlack, size: 25),
    );
  }
}