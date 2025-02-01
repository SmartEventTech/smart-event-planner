import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';

class CustomTextTheme {
  CustomTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      fontWeight: FontWeight.bold,
      color: AppColors.primaryColor,
    ),
    titleMedium: TextStyle().copyWith(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryTextColor,
    ),
    bodyMedium: TextStyle().copyWith(color: AppColors.bodyTextColor),
    titleLarge: TextStyle().copyWith(
      fontWeight: FontWeight.w800,
      fontSize: 20,
      color: AppColors.primaryTextColor,
    ),
    headlineSmall: TextStyle().copyWith(fontWeight: FontWeight.w500),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      fontWeight: FontWeight.bold,
      color: AppColors.primaryColor,
    ),
    titleMedium: TextStyle().copyWith(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryTextColor,
    ),
    bodyMedium: TextStyle().copyWith(color: AppColors.bodyTextColor),
    titleLarge: TextStyle().copyWith(
      fontWeight: FontWeight.w800,
      fontSize: 20,
      color: AppColors.primaryTextColor,
    ),
    headlineSmall: TextStyle().copyWith(fontWeight: FontWeight.w500),
  );
}
