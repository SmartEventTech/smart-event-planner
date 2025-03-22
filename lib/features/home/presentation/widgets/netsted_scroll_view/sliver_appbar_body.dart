import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/create_event_section.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/interested_section/interests_section.dart';
import 'package:smart_event_planner/shared/widgets/sections/section_heading.dart';

class SliverAppBarBody extends StatelessWidget {
  const SliverAppBarBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDark
          ? AppColors.darkSliverAppBarColor
          : AppColors.lightSliverAppBarColor,
      child: Column(
        children: [
          SizedBox(height: AppSizes.spaceBtwItem),
          CreateEventSection(),
          SizedBox(height: AppSizes.spaceBtwItem / 2),
          SectionHeading(
            title: 'Interests',
            btnTitle: 'View All',
            onPressed: () {},
          ),
          SizedBox(height: AppSizes.spaceBtwItem / 2),
          InterestsSection(),
        ],
      ),
    );
  }
}
// const Color.fromARGB(255, 24, 24, 24)
