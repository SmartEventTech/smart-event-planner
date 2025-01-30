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
    headlineSmall: TextStyle().copyWith(fontWeight: FontWeight.w600),
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
    titleLarge: TextStyle().copyWith(
      fontWeight: FontWeight.w800,
      fontSize: 20,
      color: AppColors.primaryTextColor,
    ),
    headlineSmall: TextStyle().copyWith(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Colors.black.withValues(alpha: 0.5),
    ),
  );
}
