import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/core/utils/helpers/extensions/navigation_extension.dart';
import 'package:smart_event_planner/features/create_event/presentation/screens/create_event_screen.dart';

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
        onTap: () {
          context.push(CreateEventScreen());
        },
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
