import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';

class BottomNavBarPlusIcon extends StatelessWidget {
  const BottomNavBarPlusIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Positioned(
      top: -25,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: ShapeDecoration(
            color: isDark ? AppColors.darkScaffoldBgColor : AppColors.white,
            shape: CircleBorder(),
          ),
          child: Container(
            padding: EdgeInsets.all(11),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.interestedCardColor,
            ),
            child: Center(
              child: SvgPicture.asset(AppImages.plusIcon),
            ),
          ),
        ),
      ),
    );
  }
}
