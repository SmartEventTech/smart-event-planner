import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/create_event_section.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/interests_section.dart';
import 'package:smart_event_planner/shared/widgets/sections/section_heading.dart';

class SliverAppBarBody extends StatelessWidget {
  const SliverAppBarBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.defaultScreenPadding,
          vertical: AppSizes.sm,
        ),
        child: Column(
          children: [
            SizedBox(height: AppSizes.spaceBtwItem),
            CreateEventSection(),
            SizedBox(height: AppSizes.spaceBtwItem / 2),
            SectionHeading(
              title: 'Interests',
              btnTitle: 'View All',
            ),
            //SizedBox(height: AppSizes.spaceBtwItem / 2),
            InterestsSection(),
            SizedBox(height: AppSizes.spaceBtwSection),
          ],
        ),
      ),
    );
  }
}
