import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/theme/custom_themes/custom_appbar_theme.dart';
import 'package:smart_event_planner/core/theme/custom_themes/custom_input_decoration_theme.dart';
import 'package:smart_event_planner/core/theme/custom_themes/custom_outlined_button_teme.dart';
import 'package:smart_event_planner/core/theme/custom_themes/custom_text_theme.dart';
import 'package:smart_event_planner/core/theme/custom_themes/eleveted_button_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.lightScaffoldBgColor,
    textTheme: CustomTextTheme.lightTextTheme,
    elevatedButtonTheme: CustomElevetedButtonTheme.lightElevetedButtonTheme,
    appBarTheme: CustomAppbarTheme.lightAppBarTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: CustomInputDecorationTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.darkScaffoldBgColor,
    textTheme: CustomTextTheme.darkTextTheme,
    elevatedButtonTheme: CustomElevetedButtonTheme.darkElevetedButtonTheme,
    appBarTheme: CustomAppbarTheme.darkAppBarTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: CustomInputDecorationTheme.darkInputDecorationTheme,
  );
}
