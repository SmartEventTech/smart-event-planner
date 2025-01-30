import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/suggested_section/suggested_events_section.dart';

class NestedScrollViewBody extends StatelessWidget {
  const NestedScrollViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.defaultScreenPadding,
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(height: AppSizes.spaceBtwItem),
              ),
              SuggestedEventsSection(),
            ],
          ),
        ),
      ],
    );
  }
}