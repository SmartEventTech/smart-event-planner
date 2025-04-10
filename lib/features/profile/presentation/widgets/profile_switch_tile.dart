

import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_text_style.dart';

class ProfileSwitchTile extends StatelessWidget {
  const ProfileSwitchTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.icon,
    this.activeColor,
    this.textColor,
    this.borderColor,
    this.backgroundColor,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final IconData? icon;
  final Color? activeColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    
    final effectiveTextColor =
        textColor ?? (isDark ? AppColors.white : AppColors.primaryColor);
    final effectiveBorderColor =
        borderColor ?? (isDark ? Colors.grey[800]! : Colors.grey[300]!);
    final effectiveBackgroundColor =
        backgroundColor ?? (isDark ? AppColors.mainblackColor : AppColors.white);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(width: 1, color: effectiveBorderColor),
      ),
      color: effectiveBackgroundColor,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            if (icon != null)
              Icon(
                icon,
                size: 32,
                color: isDark ? AppColors.white : AppColors.primaryColor,
              ),
            if (icon != null) const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: AppTextStyle.textStyle18ExtraBold(context).copyWith(
                  color: effectiveTextColor,
                ),
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.primaryColor,
              activeTrackColor: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
