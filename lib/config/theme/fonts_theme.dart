import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numera/config/theme/colors_theme.dart';

class AppFonts {
  static TextTheme textTheme = GoogleFonts.montserratTextTheme();

  //********************/
  // title
  //********************/
  static TextStyle title = GoogleFonts.lobsterTwo(
    fontSize: 42,
    fontWeight: FontWeight.bold,
    color: AppColors.textBlack,
  );

  //********************/
  // headline
  //********************/
  static TextStyle headline1 = GoogleFonts.montserrat(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textBlack,
  );

  static TextStyle headline2 = GoogleFonts.montserrat(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.textBlack,
  );

  static TextStyle headline3 = GoogleFonts.montserrat(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textBlack,
  );

  static TextStyle headline4 = GoogleFonts.montserrat(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textBlack,
  );

  static TextStyle headline5 = GoogleFonts.montserrat(
    fontSize: 19,
    fontWeight: FontWeight.w700,
    color: AppColors.textBlack,
  );

  static TextStyle headline6 = GoogleFonts.montserrat(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textBlack,
  );

  static TextStyle headline7 = GoogleFonts.montserrat(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: AppColors.textBlack,
  );

  static TextStyle headline8 = GoogleFonts.montserrat(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: AppColors.textBlack,
  );

  //********************/
  // body
  //********************/
  static TextStyle bodyText1 = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textBlack,
  );

  static TextStyle bodyText2 = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textBlack,
  );

  static TextStyle bodyText3 = GoogleFonts.montserrat(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: AppColors.textBlack,
  );

  static TextStyle bodyText4 = GoogleFonts.montserrat(
    fontSize: 17,
    fontWeight: FontWeight.normal,
    color: AppColors.textBlack,
  );

  static TextStyle bodyText5 = GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textBlack,
  );

  //********************/
  // miscellaneous
  //********************/
  static TextStyle appBarTitle = GoogleFonts.montserrat(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textBlack,
  );

  static TextStyle buttonText = GoogleFonts.montserrat(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
