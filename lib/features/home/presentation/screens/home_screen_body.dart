import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/create_event_section.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/interested_section/interests_section.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/suggested_section/suggested_events_section.dart';
import 'package:smart_event_planner/shared/widgets/sections/section_heading.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.defaultScreenPadding,
        vertical: AppSizes.sm,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.defaultBorderRadius),
          topRight: Radius.circular(AppSizes.defaultBorderRadius),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: AppSizes.spaceBtwItem),
                  CreateEventSection(),
                  SizedBox(height: AppSizes.spaceBtwItem / 2),
                  SectionHeading(
                    title: 'Interests',
                    btnTitle: 'View All',
                    onPressed: ()async {
                      //await TestApi().chattest(message: 'ازيك عامل اي ؟ ');
                    },
                  ),
                  SizedBox(height: AppSizes.spaceBtwItem / 2),
                  InterestsSection(),
                  SectionHeading(
                    title: 'Events you might like',
                    btnTitle: 'View All',
                    onPressed: () async {
                      //await TestApi().getEvents();
                      //await TestApi().chattest(message: 'ازيك عامل اي ؟ ');
                    },
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItem),
                ],
              ),
            ),
            SuggestedEventsListView(),
            SliverToBoxAdapter(
              child: const SizedBox(height: AppSizes.spaceBtwItem),
            ),
          ],
        ),
      ),
    );
  }
}
