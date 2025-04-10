import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_text_style.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    super.key,
    required this.title,
    this.leadingIcon = Iconsax.profile_circle,
    this.trailingIcon = Icons.arrow_forward_ios,
    this.onTap,
    this.iconColor,
    this.textColor,
    this.borderColor,
    this.backgroundColor,
    this.hideTrailing = false,
  });

  final String title;
  final IconData leadingIcon;
  final IconData? trailingIcon;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final bool hideTrailing;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final effectiveIconColor =
        iconColor ?? (isDark ? AppColors.white : AppColors.primaryColor);
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
        side: BorderSide(
          width: 1,
          color: effectiveBorderColor,
        ),
      ),
      color: effectiveBackgroundColor,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        onTap: onTap,
        leading: Icon(
          leadingIcon,
          size: 32,
          color: effectiveIconColor,
        ),
        title: Text(
          title,
          style: AppTextStyle.textStyle18ExtraBold(context).copyWith(
            color: effectiveTextColor,
          ),
        ),
        trailing: hideTrailing
            ? null
            : Icon(
                trailingIcon,
                size: 16,
                color: effectiveIconColor,
              ),
      ),
    );
  }
}
