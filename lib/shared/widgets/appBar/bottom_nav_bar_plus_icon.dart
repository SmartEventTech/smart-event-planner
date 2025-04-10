import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/features/bottom_navigation/presentation/cubit/bottom_nav_cubit.dart';

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
        onTap: () => context.read<BottomNavCubit>().changeTab(2),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: ShapeDecoration(
            color: isDark ? AppColors.mainblackColor : AppColors.white,
            shape: const CircleBorder(),
          ),
          child: Container(
            padding: const EdgeInsets.all(11),
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
