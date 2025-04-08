import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/constants/app_text_style.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {super.key,
      required this.category,
      required this.isSelected,
      this.onTap});
  final String category;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(right: AppSizes.lg, bottom: AppSizes.md),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          //padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 13.0),
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.046,
            vertical: 13.0,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.secondaryColor
                : isDark
                    ? AppColors.dark
                    : Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                offset: Offset(0, isDark ? 1 : 2),
                blurRadius: 4.0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Radio button
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                ),
              ),
              const SizedBox(width: AppSizes.slg),
              Text(
                category,
                style: AppTextStyle.textStyle20Bold(context).copyWith(
                  color: isSelected
                      ? Colors.white
                      : isDark
                          ? Colors.white
                          : Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
