import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
    required this.isSelected,
    this.onTap,
  });

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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.04,
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
              color: isSelected
                  ? AppColors.secondaryColor.withOpacity(0.6)
                  : (isDark
                      ? Colors.grey.shade800
                      : Colors.grey.shade300),
            ),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black26 : Colors.grey.shade200,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Radio indicator
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? Colors.white : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? Colors.white
                        : Colors.grey.shade400,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: AppSizes.md),
              // Category Text
              Text(
                category,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? Colors.white
                      : isDark
                          ? Colors.white
                          : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
