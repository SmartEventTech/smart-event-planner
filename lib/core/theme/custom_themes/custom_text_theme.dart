import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';

class CustomTextTheme {
  CustomTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      fontWeight: FontWeight.bold,
      color: AppColors.primaryColor,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryTextColor,
    ),
    bodyMedium: const TextStyle().copyWith(color: AppColors.bodyTextColor),
    titleLarge: const TextStyle().copyWith(
      fontWeight: FontWeight.w800,
      fontSize: 20,
      color: AppColors.primaryTextColor,
    ),
    headlineSmall: const TextStyle().copyWith(fontWeight: FontWeight.w600),
    bodyLarge: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryTextColor,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryTextColor,
    ),
    displayLarge: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryTextColor,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      fontWeight: FontWeight.bold,
      color: AppColors.primaryColor,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.white,
    ),
    titleLarge: const TextStyle().copyWith(
      fontWeight: FontWeight.w800,
      fontSize: 20,
      color: AppColors.white,
    ),
    headlineSmall: const TextStyle().copyWith(
     fontWeight: FontWeight.w600,
     color: Colors.white,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    ),
  );
}
