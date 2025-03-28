



import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';

void buildErrorBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
      ),
    );
  }
void buildSuccessBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.textBtnColor,
        content: Text(message),
      ),
    );
  }