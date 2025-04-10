import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/theme/custom_themes/custom_text_theme.dart';
import 'package:smart_event_planner/core/theme/custom_themes/custom_appbar_theme.dart';
import 'package:smart_event_planner/core/theme/custom_themes/eleveted_button_theme.dart';
import 'package:smart_event_planner/core/theme/custom_themes/custom_outlined_button_teme.dart';
import 'package:smart_event_planner/core/theme/custom_themes/custom_input_decoration_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.white, // softened blue-grey
    scaffoldBackgroundColor: Colors.white, // very soft white
    textTheme: CustomTextTheme.lightTextTheme,
    elevatedButtonTheme: CustomElevetedButtonTheme.lightElevetedButtonTheme,
    appBarTheme: CustomAppbarTheme.lightAppBarTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: CustomInputDecorationTheme.lightInputDecorationTheme,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      // ignore: deprecated_member_use
      indicatorColor: AppColors.primaryColor.withOpacity(0.2), // soft blue
      iconTheme: const WidgetStatePropertyAll(
        IconThemeData(color: Color(0xFF748C9E)), // muted tone
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF90A4AE), // desaturated cyan-grey
    scaffoldBackgroundColor: AppColors.mainblackColor,
    textTheme: CustomTextTheme.darkTextTheme,
    elevatedButtonTheme: CustomElevetedButtonTheme.darkElevetedButtonTheme,
    appBarTheme: CustomAppbarTheme.darkAppBarTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: CustomInputDecorationTheme.darkInputDecorationTheme,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.mainblackColor,
      indicatorColor: AppColors.white.withAlpha(20),
      iconTheme: const WidgetStatePropertyAll(
        IconThemeData(color: Color(0xFFB0BEC5)), // soft gray
      ),
    ),
  );
}
